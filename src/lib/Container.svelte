<script lang="ts">
	import Card from '@smui/card';
	import Fab, { Label } from '@smui/fab';
	import Chip, { Set, Text } from '@smui/chips';
	import { onMount } from 'svelte';
	import Dialog, { Actions, Title, Content } from '@smui/dialog';
	import Button from '@smui/button';
	import TextField from '@smui/textfield';
	import Checkbox from '@smui/checkbox';
	import FormField from '@smui/form-field';

	let openMatchDialog = false;
	let rememberMe = false;
	let user = '';

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
		<Button>Match</Button>
	</Actions>
</Dialog>

<div class="card">
	<Card class="card" on:click={() => (openMatchDialog = true)} style="border-radius:15px;">
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
						style="background-color: {color == 'Blue'
							? 'var(--blue-color-two)'
							: color == 'Green'
							? 'var(--green-color-two)'
							: 'white'}"
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
