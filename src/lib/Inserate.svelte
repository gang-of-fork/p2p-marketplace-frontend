<script>
	import Container from './Container.svelte';
	import Textfield from '@smui/textfield';
	import Icon from '@smui/textfield/icon';
	import Select, { Option } from '@smui/select';
	import IconButton from '@smui/icon-button';
	import Button, { Label } from '@smui/button';
	import Banner, { CloseReason } from '@smui/banner';
	import { onMount } from 'svelte';
	let openFilterBanner = false;
	export let view = 'Buy';

	export let deals = [
		{
			fromCurrency: 'BTC',
			fromAmount: 2,
			toCurrency: 'EUR',
			toAmount: 1,
			range: '2km',
			chart: ''
		}
	];

	/**
	 * @type {string[]}
	 */
	let fromCurrencies = [];
	/**
	 * @type {string[]}
	 */
	let toCurrencies = [];
	let selectedCurrencyFrom = '';
	let selectedCurrencyTo = '';
	let searchValue = '';
	$: searchValue, handleSearch();
	$: selectedCurrencyFrom, handleSearch();
	$: selectedCurrencyTo, handleSearch();

	let searchedDeals = deals;

	function handleSearch() {
		searchedDeals = [];
		for (var deal of deals) {
			if (
				(searchValue == '' ||
					searchValue == undefined ||
					deal.fromCurrency.includes(searchValue) ||
					deal.toCurrency.includes(searchValue) ||
					deal.range.includes(searchValue)) &&
				(deal.fromCurrency == selectedCurrencyFrom ||
					selectedCurrencyFrom == '' ||
					selectedCurrencyFrom == undefined) &&
				(deal.toCurrency == selectedCurrencyTo ||
					selectedCurrencyTo == '' ||
					selectedCurrencyTo == undefined)
			) {
				searchedDeals.push(deal);
			}
		}
	}

	onMount(() => {
		syncCurrencies;
	});

	function syncCurrencies() {
		for (var deal of deals) {
			if (!fromCurrencies.includes(deal.fromCurrency)) {
				fromCurrencies.push(deal.fromCurrency);
			}
			if (!toCurrencies.includes(deal.toCurrency)) {
				toCurrencies.push(deal.toCurrency);
			}
		}
	}

	function resetValues() {
		selectedCurrencyFrom = '';
		selectedCurrencyTo = '';
		searchValue = '';
	}
</script>

<div style="text-align: start; margin-left: 10px;">
	<Textfield class="shaped-outlined" variant="outlined" bind:value={searchValue} label="Search">
		<Icon class="material-icons" slot="leadingIcon">search</Icon>
	</Textfield>
	<IconButton
		class="material-icons"
		style="position: absolute; margin-top: 5px; right: 60px"
		on:click={() => (openFilterBanner = !openFilterBanner)}>filter_alt</IconButton
	>
	<IconButton
		class="material-icons"
		style="position: absolute; right: 10px; margin-top: 5px;"
		on:click={resetValues}>restart_alt</IconButton
	>
</div>
<Banner bind:open={openFilterBanner}>
	<svelte:fragment slot="actions">
		<div>
			<div class="column-element">
				{#await syncCurrencies() then data}
					<Select bind:value={selectedCurrencyFrom} label="Crypto">
						{#each fromCurrencies as currency}
							<Option value={currency}>{currency}</Option>
						{/each}
					</Select>
				{/await}
			</div>
			<div class="column-element">
				{#await syncCurrencies() then data}
					<Select bind:value={selectedCurrencyTo} label="Currency">
						{#each toCurrencies as currency}
							<Option value={currency}>{currency}</Option>
						{/each}
					</Select>
				{/await}
			</div>
		</div>
	</svelte:fragment>
</Banner>

{#each searchedDeals as deal}
	<Container {deal} color={view == 'Buy' ? 'Blue' : 'Green'} />
{/each}
{#if searchedDeals.length == 0}
	<div class="container">
		<Button href="/app/createListing{view}" variant="raised">Create Offer</Button>
	</div>
{/if}

<style>
	.container {
		text-align: center;
		width: 100%;
		height: 100%;
		padding-top: 50%;
	}

	.column-element {
		margin-left: 10px;
		border-bottom: solid thin white;
	}
</style>
