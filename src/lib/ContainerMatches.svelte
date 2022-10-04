<script lang="ts">
	import Card from '@smui/card';
	import Fab, { Label } from '@smui/fab';
	import Chip, { Set, Text } from '@smui/chips';
	import { onMount } from 'svelte';
	import Icon from '@smui/textfield/icon'

	export const deal = {
		offer: {
			_id: 'string',
			name: 'Offer Error',
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
			user: 'string',
			offer: 'string',
			hash: 'string'
		}
	};

	onMount(async () => {});
</script>

<div class="card">
	<Card class="card" style="border-radius:15px;">
		<h3>{deal.offer.name}</h3>
		<div style="margin-bottom: 15px; margin-top: -20px;">
			<div class="borderedContainer row-element">
				<div>
					<h3 style="margin-right: 8px;">{deal.offer.cryptoAmount} {deal.offer.crypto}</h3>
				</div>
			</div>
			<div class="row-element">
				<Icon class="material-icons" style="font-size: 50px; transform: translate(0px, 15px);"> arrow_forward </Icon>
			</div>
			<div class="borderedContainer row-element">
				<div >
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
