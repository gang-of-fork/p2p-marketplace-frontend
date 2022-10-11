<script>
	import Card from '@smui/card';
	import Fab, { Label } from '@smui/fab';
	import Chip, { Set, Text } from '@smui/chips';
	import { onMount } from 'svelte';
	import Icon from '@smui/textfield/icon';
	import Dialog, { Actions, Title, Content } from '@smui/dialog';

	let openDetailDialog = false;

	export const deal = {
		offer: {
			_id: 'string',
			name: 'string',
			type: 'BUY',
			location: [0, 0],
			currrencyAmount: 120000,
			cryptoAmount: 0.55,
			crypto: 'BTC',
			currency: 'GBP'
		},
		match: {
			_id: 'string',
			viewedAt: '2022-10-04T18:16:04.077Z',
			createdAt: '2022-10-04T18:16:04.077Z',
			name: 'string',
			user: 'LinkUserProfile',
			offer: 'string',
			hash: 'string'
		}
	};

	let time = new Date();
	onMount(() => {
		const interval = setInterval(() => {
			time = new Date();
		}, 1000);

		return () => {
			clearInterval(interval);
		};
	});
	let expirationDate = new Date(deal.match.viewedAt);
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
		minutes = seconds >= 30 ? minutes + 1 : minutes;
		minutes = minutes % 60;
		hours = hours % 24;

		return `${padTo2Digits(hours)}:${padTo2Digits(minutes)}:${padTo2Digits(seconds)}`;
	}
</script>

<Dialog
	bind:open={openDetailDialog}
	aria-labelledby="simple-title"
	aria-describedby="simple-content"
>
	<Title id="simple-title" style="color: white">Details</Title>
	<Content id="simple-content">
		<div style="text-align: start;">
			<h3>Name : {deal.offer.name}</h3>
			<h3>Type : {deal.offer.type}</h3>
			<h3>Currency Amount : {deal.offer.currrencyAmount}</h3>
			<h3>Currency : {deal.offer.currency}</h3>
			<h3>Crypto Amount : {deal.offer.cryptoAmount}</h3>
			<h3>Crypto : {deal.offer.crypto}</h3>
			<h3>User: <a>{deal.match.user}</a></h3>
			<h3>Expiration Time : {convertMsToHMS(expirationTime)}</h3>
		</div>
	</Content>
</Dialog>

<div class="card">
	<Card on:click={()=>(openDetailDialog=true)} class="card" style="border-radius:15px;">
		<h3>{deal.offer.name}</h3>
		<div style="margin-bottom: 15px; margin-top: -20px;">
			<div class="borderedContainer row-element">
				<div>
					<h3 style="margin-right: 8px;">{deal.offer.cryptoAmount} {deal.offer.crypto}</h3>
				</div>
			</div>
			<div class="row-element">
				<Icon class="material-icons" style="font-size: 50px; transform: translate(0px, 15px);">
					arrow_forward
				</Icon>
			</div>
			<div class="borderedContainer row-element">
				<div>
					<h3 style="margin-left: 8px;">{deal.offer.currrencyAmount} {deal.offer.currency}</h3>
				</div>
				<div />
			</div>
		</div></Card
	>
</div>

<style>
	.row-element {
		display: inline-block;
		margin: auto;
	}

	.borderedContainer {
		border-color: white;
		background-color: grey;
		border-radius: 15px;
		width: max-content;
		padding: 5px;
		padding-top: 0;
		padding-bottom: 0;
	}

	.card {
		margin: 10px;
	}
</style>
