<script>
	import Card from '@smui/card';
	import { dataset_dev } from 'svelte/internal';
	import {jwt, BACKEND_SERVER} from '../../../stores';
	import { onMount } from 'svelte';
	import LayoutGrid, { Cell } from '@smui/layout-grid';
	import Paper, { Title, Subtitle, Content } from '@smui/paper';
	import Select, { Option } from '@smui/select';
	import Slider from '@smui/slider';
	import Button from '@smui/button';
	import { BACKEND_SERVER, jwt } from '../../../stores';
	import { goto } from '$app/navigation';

	/**
	 * @type {string}
	 */
	let loginToken;
	jwt.subscribe((value) => {
		loginToken = value;
	});

	let currencies = ['EUR', 'USD', 'CAD', 'GBP'];
	let cryptoCurrencies = ['BTC', 'ETH', 'MON', 'CLT'];

	let currency = '';
	let crypto = '';
	let currenciesFilled = false;
	let sliderMin = 0;
	let sliderMax = 100;
	let longitudeInput = 0;
	let latitudeInput = 0;
	let inputValue = 1;

	onMount(async () => {
		if (loginToken == '') {
			goto('/');
		}
	});

	//@ts-ignore
	function checkCurrencyFilled(currency, crypto) {
		if (currency == '' || crypto == '') {
			currenciesFilled = false;
		} else {
			currenciesFilled = true;
		}
	}

	$: checkCurrencyFilled(currency, crypto);

	async function sendDataBackend() {
		//When called sends all the data back to the backend
		const newOffer = {
			type: 'Sell',
			location: [latitudeInput, longitudeInput],
			currencyAmount: 1,
			cryptoAmount: inputValue,
			crypto: crypto,
			currency: currency
		};

		await fetch(`${BACKEND_SERVER}/offers/`, {
			headers: {
				Authorization: `Bearer ${loginToken}`,
				'Content-Type': 'application/json'
			},
			method: 'POST',
			// @ts-ignore
			body: JSON.stringify(newOffer)
		});
	}
</script>

<svelte:head>
	<title>createListingSell</title>
	<meta name="description" content="createListingSell" />
</svelte:head>

<body>
	<h1>Create Listing Buy</h1>

	<LayoutGrid fixedColumnWidth>
		<Cell span={12}>
			<Paper color="custom-black">
				<Title>Verkaufsgeschäft</Title>
				<Subtitle>Mit welchen Währungen möchten Sie handeln?</Subtitle>
				<Content>
					<Cell span={1}>
						<div class="cell">
							<div>
								<Select
									class="shaped-outlined"
									variant="outlined"
									bind:value={crypto}
									label="Crypto Currencies"
								>
									<Option value="" />
									{#each cryptoCurrencies as cryptoCurrency}
										<Option value={cryptoCurrency}>{cryptoCurrency}</Option>
									{/each}
								</Select>
							</div>
							<div style="padding: 10px">
								<Select
									class="shaped-outlined"
									variant="outlined"
									bind:value={currency}
									label="Currencies"
								>
									<Option value="" />
									{#each currencies as currency}
										<Option value={currency}>{currency}</Option>
									{/each}
								</Select>
							</div>
						</div>
					</Cell>
				</Content>
			</Paper>
		</Cell>
		<Cell span={12}>
			<Paper class="paper">
				<Title>Verkaufspreis</Title>
				{#if currenciesFilled}
					<Subtitle
						>Sie sind bereit einen {crypto} für minimal {inputValue}
						{currency} zu verkaufen.</Subtitle
					>
					<Content>
						<div class="cell">
							<Slider bind:value={inputValue} min={sliderMin} max={sliderMax} />
						</div>
						<div style="text-align:center">
							<input bind:value={inputValue} class="inputFields" type="number" />
						</div>
					</Content>
				{/if}
				{#if !currenciesFilled}
					<Content>
						<p>Sie müssen zuerst beide gewünschten Währungen angeben.</p>
					</Content>
				{/if}
			</Paper>
		</Cell>
		<Cell span={12}>
			<Paper>
				<Title>Standort</Title>
				{#if currenciesFilled}
					<Subtitle>Wo soll ihr gewünschtes Geschäft stattfinden?</Subtitle>
					<Content>
						<div
							class="rangeDiv"
							style="display: flex;
					align-items: center;
					justify-content: center; "
						>
							<div>
								<p>Latitude</p>
								<input
									bind:value={latitudeInput}
									Label="Latitude"
									class="inputFields"
									type="number"
									min={-90}
									max={90}
								/>
							</div>
							<div>
								<p>Longitude</p>
								<input
									bind:value={longitudeInput}
									Label="Longitude"
									class="inputFields"
									type="number"
									min={-180}
									max={180}
								/>
							</div>
						</div>
					</Content>
				{/if}
				{#if !currenciesFilled}
					<Content>
						<p>Sie müssen zuerst beide gewünschten Währungen angeben.</p>
					</Content>
				{/if}
			</Paper>
		</Cell>
		<Cell span={12}>
			{#if currenciesFilled}
				<div class="buttonNav">
					<Button variant="outlined" href="/app/home">Back</Button>
					<Button variant="raised" href="/app/buy" on:click={sendDataBackend}>Search</Button>
				</div>
			{/if}
			{#if !currenciesFilled}
				<p>Bitte füllen Sie alle Werte korrekt aus.</p>
			{/if}
		</Cell>
		<Cell>
			<br />
			<br />
			<br />
			<br />
			<br />
		</Cell>
	</LayoutGrid>
</body>

<style>
	body {
		width: 100%;
		height: 100%;
	}

	input {
		font-size: 14px;
		padding: 10px 25px 10px 10px;
		border: 1px solid #ccc;
	}

	.inputFields {
		width: 80px;
		text-align: center;
	}

	.rangeDiv {
		overflow: hidden;
	}

	.rangeDiv::after {
		clear: both;
		display: block;
	}

	h1 {
		color: white;
	}

	.cell {
		width: 100%;
		text-align: center;
	}

	* :global(.shaped-outlined),
	* {
		border-radius: 28px;
		margin: 3px;
	}

	* :global(.shaped-outlined .mdc-text-field__input) {
		padding-left: 32px;
		padding-right: 0;
	}

	* :global(.shaped-outlined .mdc-notched-outline .mdc-notched-outline__leading) {
		border-radius: 28px 0 0 28px;
		width: 28px;
	}

	* :global(.shaped-outlined .mdc-notched-outline .mdc-notched-outline__trailing) {
		border-radius: 0 28px 28px 0;
	}

	* :global(.shaped-outlined .mdc-notched-outline .mdc-notched-outline__notch) {
		max-width: calc(100% - 28px * 2);
	}
</style>
