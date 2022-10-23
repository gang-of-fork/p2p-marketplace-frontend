<script>
	import Web3 from 'web3';

	import { jwt, BACKEND_SERVER } from '../stores';
	import { onMount } from 'svelte';
	import { goto } from '$app/navigation';

	import Button from '@smui/button';

	import { Buffer } from 'buffer';
	globalThis.Buffer = Buffer;

	let paused = false;
	/**
	 * @type {HTMLVideoElement}
	 */
	let video;
	/**
	 * @type {HTMLAudioElement}
	 */
	let audio;
	/**
	 * @type {string}
	 */
	let loginToken;
	jwt.subscribe((value) => {
		loginToken = value;
	});

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
				window.alert('Login wiederholen');
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
			params: [(await web3.eth.requestAccounts())[0]]
		});
		await fetch(`${BACKEND_SERVER}/auth/register`, {
			body: JSON.stringify({ publicAddress, publicKey }),
			headers: {
				'Content-Type': 'application/json'
			},
			method: 'POST'
		}).then((response) => response.json());
	}

	function handlePaused() {
		paused = !paused;
		if (paused) {
			audio.pause();
			video.pause();
		} else {
			audio.play();
			video.play();
		}
	}
</script>

<svelte:head>
	<title>login</title>
	<meta name="description" content="login" />
</svelte:head>

<video bind:this={video} autoplay muted loop src="../background.mp4" id="myVideo" />

<div class="content">
	<h1 style="margin-top: 50px">Welcome</h1>
	<div class="plantTitle" title="PlantExchange">PlantExchange</div>
	<br />
	<h2>The first anonymous crypto-currency marketplace in the World Wide Web.</h2>
	<br />

	<Button style="margin-top: 100px; margin-bottom: 25px" on:click={handleClick} variant="raised"
		>Login</Button
	>
	<br />
	<h2>
		Please sign up with MetaMask Single-Sig-On to remain completely anonymous when using this
		platform.
	</h2>

	<audio bind:this={audio} autoplay loop src="../track2.mp3" />
	<i on:click={handlePaused} class="material-icons" style="font-size: 50px;">
		{paused ? 'play_circle' : 'pause_circle'}
	</i>
</div>

<style>
	#myVideo {
		position: fixed;
		right: 0;
		bottom: 0;
	}
	.content {
		position: fixed;
		color: #f1f1f1;
		width: 100%;
		height: 100%;
	}
	.material-icons {
		position: absolute;
		font-size: 50px;
		bottom: 10px;
		right: 10px;
	}

	@media (min-aspect-ratio: 16/9) {
		#myVideo {
			width: 100%;
			min-height: auto;
		}
	}

	@media (max-aspect-ratio: 16/9) {
		#myVideo {
			width: auto;
			height: 100%;
		}
	}
</style>
