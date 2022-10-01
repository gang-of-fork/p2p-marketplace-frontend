<script>
	import Web3 from 'web3';

	import {jwt, BACKEND_SERVER} from '../../stores';

	/**
	 * @type {string}
	 */
	let loginToken;
    jwt.subscribe(value => {loginToken = value})

	/**
	 * @type {Web3 | null}
	 */
	let web3 = null;

	/**
	 * @param {string} publicAddress
	 * @param {string} signature
	 */
	async function handleAuthenticate(publicAddress, signature) {
		const response = await fetch(`${BACKEND_SERVER}/auth/login`, {
			body: JSON.stringify({ publicAddress, signature }),
			headers: {
				'Content-Type': 'application/json'
			},
			method: 'POST'
		}).then((response) => response.json());
		jwt.set(response.jwt);
	}

	async function handleClick() {
		if (!window.web3) {
			window.alert('Please install MetaMask first.');
			return;
		}
		if (!web3) {
			// We don't know window.web3 version, so we use our own instance of web3
			// with provider given by window.web3
			// @ts-ignore
			web3 = new Web3(window.web3.currentProvider);
		}
		if (!(await web3.eth.getCoinbase())) {
			window.alert('Please activate MetaMask first.');
			return;
		}
		const publicAddress = (await web3.eth.getCoinbase()).toLowerCase();

		// Look if user with current publicAddress is already present on backend
		await fetch(`${BACKEND_SERVER}/auth/login/${publicAddress}`)
			.then((response) => response.json())
			// If yes, retrieve it. If no, create it.
			.then((user) => (user.publicAddress != undefined ? user.nonce : handleSignup(publicAddress)))
			// Popup MetaMask confirmation modal to sign message
			.then((nonce) => handleSignMessage(publicAddress, nonce))
			// Send signature to backend on the /auth route
			.then((signature) => handleAuthenticate(publicAddress, signature))
			.catch((err) => {
				window.alert(err);
			});
	}

	/**
	 * @param {string} publicAddress
	 * @param {string} nonce
	 */
	function handleSignMessage(publicAddress, nonce) {
		return new Promise((resolve, reject) =>
			// @ts-ignore
			web3.eth.personal.sign(
				// @ts-ignore
				`I am signing my one-time nonce: ${nonce}`,
				publicAddress,
				// @ts-ignore
				(err, signature) => {
					if (err) return reject(err);
					return resolve(signature);
				}
			)
		);
	}

	/**
	 * @param {string} publicAddress
	 */
	async function handleSignup(publicAddress) {
		await fetch(`${BACKEND_SERVER}auth/register`, {
			body: JSON.stringify({ publicAddress }),
			headers: {
				'Content-Type': 'application/json'
			},
			method: 'POST'
		}).then((response) => response.json());
	}
</script>

<svelte:head>
	<title>login</title>
	<meta name="description" content="login" />
</svelte:head>

<h1>Test</h1>
{#if loginToken == ''}
	<button on:click={handleClick}>Login</button>
{:else}
	<span>You are already logged in</span>
{/if}
