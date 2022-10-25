<script>
	import Card from '@smui/card';
	import Fab, { Label } from '@smui/fab';
	import Chip, { Set, Text } from '@smui/chips';
	import { onMount } from 'svelte';
	import Icon from '@smui/textfield/icon';
	import Dialog, { Actions, Title, Content } from '@smui/dialog';
	import { BACKEND_SERVER, jwt } from '../stores';
	import { ethers } from 'ethers';

	/**
	 * @type {string}
	 */
	let loginToken;
	jwt.subscribe((value) => {
		loginToken = value;
	});

	let openDetailDialog = false;

	export let match = {
		_id: 'string',
		name: 'string'
	};

	let deal = {
		match: {
			_id: 'string',
			viewedAt: '2022-10-04T18:16:04.077Z',
			createdAt: '2022-10-04T18:16:04.077Z',
			name: 'string',
			hash: 'LinkUserProfile',
			offer: 'string'
		},
		offer: {
			_id: 'string',
			name: 'Offer Error',
			type: 'BUY',
			location: [0, 0],
			currrencyAmount: 120000,
			cryptoAmount: 0.55,
			crypto: 'BTC',
			currency: 'GBP'
		}
	};

	let encrypted = false;

	let time = new Date();
	onMount(() => {
		const interval = setInterval(() => {
			time = new Date();
		}, 1000);

		return () => {
			clearInterval(interval);
		};
	});
	let expirationDate = new Date(deal.match.createdAt);
	expirationDate.setDate(expirationDate.getDate() + 1);
	$: expirationTime = expirationDate.getTime() - time.getTime();

	/**
	 * @param {number} num
	 */
	function padTo2Digits(num) {
		return num.toString().padStart(2, '0');
	}

	/**
	 * @param {number} milliseconds
	 */
	function convertMsToHMS(milliseconds) {
		let seconds = Math.floor(milliseconds / 1000);
		let minutes = Math.floor(seconds / 60);
		let hours = Math.floor(minutes / 60);

		seconds = seconds % 60;
		// 👇️ if seconds are greater than 30, round minutes up (optional)
		minutes = seconds >= 30 ? minutes + 1 : minutes;

		minutes = minutes % 60;

		// 👇️ If you don't want to roll hours over, e.g. 24 to 00
		// 👇️ comment (or remove) the line below
		// commenting next line gets you `24:00:00` instead of `00:00:00`
		// or `36:15:31` instead of `12:15:31`, etc.
		hours = hours % 24;

		return `${padTo2Digits(hours)}:${padTo2Digits(minutes)}:${padTo2Digits(seconds)}`;
	}

	async function fetchMatch() {
		deal.match = await fetch(`${BACKEND_SERVER}/matches/${match._id}`, {
			headers: {
				Authorization: `Bearer ${loginToken}`
			}
		}).then((response) => response.json());
		console.log(deal.match);
		deal.offer = await fetch(`${BACKEND_SERVER}/offers/${deal.match.offer}`, {
			headers: {
				Authorization: `Bearer ${loginToken}`
			}
		}).then((response) => response.json());
		console.log(deal);
		openDetailDialog = true;
	}
	async function handleEncrypt() {
		deal.match.hash = await window.ethereum.request({
			method: 'eth_decrypt',
			params: [stringifiableToHex(deal.match.hash), window.ethereum.selectedAddress]
		});
		encrypted = true;
	}

	/**
	 * @param {any} value
	 */
	function stringifiableToHex(value) {
		return ethers.utils.hexlify(Buffer.from(JSON.stringify(value)));
	}
</script>

<Dialog
	bind:open={openDetailDialog}
	aria-labelledby="simple-title"
	aria-describedby="simple-content"
>
	<!-- Title cannot contain leading whitespace due to mdc-typography-baseline-top() -->
	<Title id="simple-title" style="color: white">Details</Title>
	<Content id="simple-content">
		<div style="text-align: start;">
			<h3>Name : {deal.offer.name}</h3>
			<h3>Type : {deal.offer.type}</h3>
			<h3>Currency Amount : {deal.offer.currrencyAmount}</h3>
			<h3>Currency : {deal.offer.currency}</h3>
			<h3>Crypto Amount : {deal.offer.cryptoAmount}</h3>
			<h3>Crypto : {deal.offer.crypto}</h3>
			<h3>
				User: <a style="visibility: {encrypted ? 'hidden' : 'visible'}" on:click={handleEncrypt}
					>Encrypt</a
				>
				{deal.match.hash}
			</h3>
			<h3>Expiration Time : {convertMsToHMS(expirationTime)}</h3>
		</div>
	</Content>
</Dialog>

<div class="card">
	<Card on:click={fetchMatch} class="card" style="border-radius:15px;">
		<h1>{match.name}</h1>
	</Card>
</div>

<style>
	.card {
		margin: 10px;
	}
</style>
