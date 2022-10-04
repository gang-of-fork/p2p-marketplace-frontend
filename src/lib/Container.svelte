<script lang="ts">
	import Card from '@smui/card';
	import Fab, { Label } from '@smui/fab';
	import Chip, { Set, Text } from '@smui/chips';
	import { onMount } from 'svelte';

	export let deal = {
		fromCurrency: 'ERR',
		fromAmount: -1,
		toCurrency: 'ERR',
		toAmount: -1,
		range: '',
		chart: ''
	};
	export let color = 'Blue';
	let searchValue = '';

	onMount(async () => {
		let response = await fetch(
			`https://api.binance.com/api/v3/avgPrice?symbol=${deal.fromCurrency}${deal.toCurrency}`
		).then((response) => response.json());
		var price = parseFloat(response.price);
		deal.chart = price.toFixed(2);
	});
</script>

<div class="card">
	<Card class="card" style="border-radius:15px;">
		<div class="container">
			<div class="row-element" style="margin-left: 0px">
				<div>
					<div class="row-element">
						<h1 style="margin-right: 8px;">{deal.fromAmount}</h1>
					</div>
					<div class="row-element">
						<i class="material-icons"> arrow_forward </i>
					</div>
					<div class="row-element">
						<h1 style="margin-left: 8px;">{deal.toAmount}</h1>
					</div>
				</div>
				<div style="margin-top: -15px;">
					<div class="row-element">
						<Set chips={[deal.fromCurrency]} let:chip nonInteractive>
							<Chip
								{chip}
								style="background-color: {color == 'Blue'
									? '#6200ee'
									: color == 'Green'
									? '#018786'
									: 'white'}"
							>
								<Text><span style="color: white;">{chip}</span></Text>
							</Chip>
						</Set>
					</div>
					<div class="row-element">
						<Set chips={[deal.toCurrency]} let:chip nonInteractive>
							<Chip {chip}>
								<Text>{chip}</Text>
							</Chip>
						</Set>
					</div>
				</div>
			</div>

			<div class="row-element" style="flex: 1">
				{#if deal.range != ''}
					<Fab
						href="/app/deal"
						style="background-color: {color == 'Blue'
							? '#6200ee'
							: color == 'Green'
							? '#018786'
							: 'white'};"
					>
						{deal.range}
					</Fab>
				{/if}
			</div>

			<div class="row-element">
				<img class="cardImage" src="../chart{color}.PNG" alt="background chart" />
				<div class="centered">
					<Fab
						extended
						style="background: rgba(255, 255, 255, 0.38);
					border-radius: 16px;
					box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
					backdrop-filter: blur(2.9px);
					-webkit-backdrop-filter: blur(2.9px); padding: 5px; height: 40px;"><Label>{deal.chart}</Label></Fab
					>
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
