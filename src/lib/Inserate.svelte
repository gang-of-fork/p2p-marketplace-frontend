<script>
	import Container from './Container.svelte';
	import Textfield from '@smui/textfield';
	import Icon from '@smui/textfield/icon';
	import Select, { Option } from '@smui/select';
	import IconButton from '@smui/icon-button';
	import Button, { Label } from '@smui/button';
	import Banner, { CloseReason } from '@smui/banner';
	import PickAPlace from 'svelte-pick-a-place';
	import leaflet from 'leaflet';
	import Dialog, { Title, Content } from '@smui/dialog';
	import { onMount } from 'svelte';
	let openFilterBanner = false;
	let openLocationDialog = true;
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
		style="position: absolute; margin-top: 5px; right: 120px"
		href="/app/location">location_on</IconButton
	>
	<IconButton
		class="material-icons"
		style="position: absolute; margin-top: 5px; right: 60px"
		href="/app/location"
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
		<PickAPlace
			{leaflet}
			on:update={() => console.log('Update!')}
			on:save={() => console.log('On save!')}
		/>
	</svelte:fragment>
</Banner>

<dialog
	open={openLocationDialog}
	style="width: -webkit-fill-available; height: -webkit-fill-available;"
>
		<div style="overflow: hidden; width: max-width; height: max-height;">
			<PickAPlace
				{leaflet}
				on:update={() => console.log('Update!')}
				on:save={() => console.log('On save!')}
			/>
		</div>
</dialog>
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
