<script>
	import Card from '@smui/card';
	import Fab, { Label } from '@smui/fab';
	import Chip, { Set, Text } from '@smui/chips';
	import { onMount } from 'svelte';
	import Dialog, { Actions, Title, Content } from '@smui/dialog';
	import Button from '@smui/button';
	import TextField from '@smui/textfield';
	import Checkbox from '@smui/checkbox';
	import FormField from '@smui/form-field';
	import Web3 from 'web3';
	import { BACKEND_SERVER, jwt, userAddress } from '../stores';
	import { encrypt } from '@metamask/eth-sig-util';
	import { ethers } from 'ethers';

	let openMatchDialog = false;
	let rememberMe = false;
	let user = '';

	userAddress.subscribe((value) => {
		user = value;
	});

	/**
	 * @type {string}
	 */
	let loginToken;
	jwt.subscribe((value) => {
		loginToken = value;
	});

	export let deal = {
		_id: '',
		crypto: 'BTC',
		currency: 'GBP',
		location: [0, 0],
		name: 'Morus alba',
		range: 0,
		cryptoAmount: 0,
		currencyAmount: 0,
		chart: ''
	};
	export let color = 'Blue';

	onMount(async () => {
		try {
			let response = await fetch(
				`https://api.binance.com/api/v3/avgPrice?symbol=${deal.crypto}${deal.currency}${
					deal.currency == 'USD' ? 'T' : ''
				}`
			).then((response) => response.json());
			var price = parseFloat(response.price);
			deal.chart = price.toFixed(2);
		} catch (e) {}
	});

	async function handleMatch() {
		if (rememberMe) {
			userAddress.set(user);
		}
		const response = await fetch(`${BACKEND_SERVER}/offers/${deal._id}/match`, {
			headers: {
				Authorization: `Bearer ${loginToken}`
			},
			method: 'POST'
		}).then((response) => response.json());
		console.log(response);
		submitContact(encryptUser(response.publicKey), response.match);
	}

	/**
	 * @param {any} publicKey
	 */
	function encryptUser(publicKey) {
		//@ts-ignore
		return stringifiableToHex(encrypt({ publicKey: publicKey, data: user, version: 'x25519-xsalsa20-poly1305' }));
	}

	/**
	 * @param {any} ciphertext
	 * @param {any} match
	 */
	async function submitContact(ciphertext, match) {
		const response = await fetch(`${BACKEND_SERVER}/matches/${match}/submit`, {
			method: 'POST',
			headers: {
				Authorization: `Bearer ${loginToken}`,
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({
				hash: ciphertext
			})
		}).then((response) => response.json());
	}

	/**
	 * @param {any} value
	 */
	 function stringifiableToHex(value) {
		return ethers.utils.hexlify(Buffer.from(JSON.stringify(value)));
	}
</script>

<Dialog
	bind:open={openMatchDialog}
	aria-labelledby="simple-title"
	aria-describedby="simple-content"
>
	<!-- Title cannot contain leading whitespace due to mdc-typography-baseline-top() -->
	<Title id="simple-title" style="color: white">Would you like to match this offer?</Title>
	<Content id="simple-content">
		<TextField bind:value={user} label="User" />
		<FormField>
			<Checkbox bind:checked={rememberMe} />
			<h3 slot="label">Remember me.</h3>
		</FormField>
	</Content>
	<Actions>
		<Button on:click={handleMatch}>Match</Button>
	</Actions>
</Dialog>

<div class="card">
	<Card class="card" on:click={() => (openMatchDialog = true)} style="border-radius:15px;">
		<div class="container">
			<div class="row-element" style="margin-left: 0px">
				<div>
					<div class="row-element">
						<h1 style="margin-right: 8px;">
							{color == 'blue' ? deal.cryptoAmount : deal.currencyAmount}
						</h1>
					</div>
					<div class="row-element">
						<i class="material-icons"> arrow_forward </i>
					</div>
					<div class="row-element">
						<h1 style="margin-left: 8px;">
							{color == 'blue' ? deal.currencyAmount : deal.cryptoAmount}
						</h1>
					</div>
				</div>
				<div style="margin-top: -15px;">
					<div class="row-element">
						<Set chips={[color == 'blue' ? deal.currency : deal.crypto]} let:chip nonInteractive>
							<Chip
								{chip}
								style="background-color: {color == 'Blue'
									? 'var(--blue-color-two)'
									: color == 'Green'
									? 'var(--green-color-two)'
									: 'white'}"
							>
								<Text><span style="color: white;">{chip}</span></Text>
							</Chip>
						</Set>
					</div>
					<div class="row-element">
						<Set chips={[color == 'blue' ? deal.crypto : deal.currency]} let:chip nonInteractive>
							<Chip {chip}>
								<Text>{chip}</Text>
							</Chip>
						</Set>
					</div>
				</div>
			</div>

			<div class="row-element">
				<img class="cardImage" src="../chart{color}.PNG" alt="background chart" />
				<div class="centered">
					{#if deal.chart != ''}
						<Fab
							extended
							style="background: rgba(255, 255, 255, 0.38);
					border-radius: 16px;
					box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
					backdrop-filter: blur(2.9px);
					-webkit-backdrop-filter: blur(2.9px); padding: 5px; height: 40px; position: absolute; right: 10px"
							><Label>{deal.chart}</Label></Fab
						>
					{/if}
				</div>
			</div>
		</div>
	</Card>
</div>

<style>
	.row-element {
		display: inline-block;
		margin: auto;
	}

	.container {
		display: flex;
	}

	.card {
		margin: 10px;
	}

	.centered {
		margin-right: 10px;
	}

	.cardImage {
		border-top-right-radius: 15px;
		border-bottom-right-radius: 15px;
		max-width: 115px;
		height: 100%;
		position: absolute;
		right: 0;
		top: 0;
	}
</style>
