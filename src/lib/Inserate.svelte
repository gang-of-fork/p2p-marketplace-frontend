<script>
	import Container from './Container.svelte';
	import Textfield from '@smui/textfield';
	import Icon from '@smui/textfield/icon';
	import Select, { Option } from '@smui/select';
	import Dialog, { Title, Content, Actions } from '@smui/dialog';
	import IconButton from '@smui/icon-button';
	import Button, { Label } from '@smui/button';
	import { onMount } from 'svelte';
	let openFilterDialog = false;

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

<Dialog
	bind:open={openFilterDialog}
	aria-labelledby="simple-title"
	aria-describedby="simple-content"
	style="height: 400px; margin-top: 100px;"
>
	<!-- Title cannot contain leading whitespace due to mdc-typography-baseline-top() -->
	<Title id="simple-title" style="color: white">Filter</Title>
	<Actions>
		<div>
			<div class="row-element">
				{#await syncCurrencies() then data}
					<Select bind:value={selectedCurrencyFrom} label="Currency From">
						{#each fromCurrencies as currency}
							<Option value={currency}>{currency}</Option>
						{/each}
					</Select>
				{/await}
			</div>
			<div class="row-element">
				{#await syncCurrencies() then data}
					<Select bind:value={selectedCurrencyTo} label="Currency To">
						{#each toCurrencies as currency}
							<Option value={currency}>{currency}</Option>
						{/each}
					</Select>
				{/await}
			</div>
		</div>
	</Actions>
</Dialog>

<div style="text-align: start; margin-left: 10px;">
	<Textfield class="shaped-outlined" variant="outlined" bind:value={searchValue} label="Search">
		<Icon class="material-icons" slot="leadingIcon">search</Icon>
	</Textfield>
	<IconButton
		class="material-icons"
		style="position: absolute; margin-top: 5px; right: 60px"
		on:click={() => (openFilterDialog = true)}>filter_alt</IconButton
	>
	<IconButton
		class="material-icons"
		style="position: absolute; right: 10px; margin-top: 5px;"
		on:click={resetValues}>restart_alt</IconButton
	>
</div>

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

	.row-element {
		display: inline-block;
		margin: auto;
	}
</style>
