<script>
	import Web3 from 'web3';

	import { jwt, BACKEND_SERVER } from '../stores';
	import { onMount } from 'svelte';
	import { goto } from '$app/navigation';

    import Button from '@smui/button';

	/**
	 * @type {string}
	 */
	let loginToken;
	jwt.subscribe((value) => {
		loginToken = value;
	});
	/**
	 * @type {any[]}
	 */
	let accounts;

	/**
	 * @type {Web3 | null}
	 */
	let web3 = null;

	onMount(async () => {
		if (loginToken != '') {
			goto('/app/home');
		}
	});

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
		goto('/app/home');
	}

	async function handleClick() {
		// @ts-ignore
		if (!window.web3) {
			window.alert('Please install MetaMask first.');
			return;
		}
		if (!web3) {
			// We don't know window.web3 version, so we use our own instance of web3
			// with provider given by window.web3
			// @ts-ignore
			web3 = new Web3(window.ethereum);
			console.log();
		}
		if (!(await web3.eth.getCoinbase())) {
			await web3.eth.requestAccounts();
		}
		const publicAddress = (await web3.eth.getCoinbase()).toLowerCase();

		// Look if user with current publicAddress is already present on backend
		await fetch(`${BACKEND_SERVER}/auth/login/${publicAddress}`)
			.then((response) => response.json())
			// If yes, retrieve it. If no, create it.
			.then((user) => (user.publicAddress != undefined ? user.nonce : handleSignup(publicAddress)))
			// Popup MetaMask confirmation modal to sign message
			.then((nonce) => handleSignMessage(publicAddress, nonce))
			// Send signature to backend on the /auth route and encryption key
			.then((signature) => handleAuthenticate(publicAddress, signature))
			.catch((err) => {
				window.alert("Login wiederholen");
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
		var publicKey = await window.ethereum.request({
          method: 'eth_getEncryptionPublicKey',
          params: [(await web3.eth.requestAccounts())[0]],
        });
		await fetch(`${BACKEND_SERVER}/auth/register`, {
			body: JSON.stringify({ publicAddress, publicKey }),
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

<div>
	<h1 style="margin-top: 50px">Welcome</h1>
	<h3>to PlantExchange!</h3>
	<br />
	<h2>The first anonymous crypto-currency marketplace in the World Wide Web.</h2>
	<br />

	<Button style="margin-top: 100px; margin-bottom: 25px" on:click={handleClick} variant="raised">Login</Button>
	<br />
	<h2>
		Please sign up with MetaMask Single-Sig-On to remain completely anonymous when using this
		platform.
    </h2>

	<audio autoplay loop src="../track.mp3" />
</div>
