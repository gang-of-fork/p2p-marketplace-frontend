<script>
	import Container from './Container.svelte';
	import Textfield from '@smui/textfield';
	import Icon from '@smui/textfield/icon';
	import Select, { Option } from '@smui/select';
	import IconButton from '@smui/icon-button';
	import Button, { Label } from '@smui/button';
	import Banner, { CloseReason } from '@smui/banner';
	import { BACKEND_SERVER, jwt } from '../stores';
	import { onMount } from 'svelte';
	let openFilterBanner = false;
	export let view = 'BUY';
	/**
	 * @type {string}
	 */
	 let loginToken;
	jwt.subscribe((value) => {
		loginToken = value;
	});
	/**
	 * @type {any}
	 */
	let latitude = 0;
	/**
	 * @type {any}
	 */
	let longitude = 0;

	export let deals = [
		{	
			_id: '',
			crypto: 'BTC',
			currency: 'GBP',
			location: [0, 0],
			name: 'Morus alba',
			range: 0,
			cryptoAmount: 0,
			currencyAmount: 0,
			chart: ''
		}
	];

	/**
	 * @type {string[]}
	 */
	let cryptos = [];
	/**
	 * @type {string[]}
	 */
	let currencies = [];
	let selectedCrypto = '';
	let selectedCurrency = '';
	let searchValue = '';
	$: searchValue, handleSearch();
	$: selectedCrypto, handleSearch();
	$: selectedCurrency, handleSearch();

	let searchedDeals = deals;

	function handleSearch() {
		searchedDeals = [];
		for (var deal of deals) {
			if (
				(searchValue == '' ||
					searchValue == undefined ||
					deal.crypto.includes(searchValue) ||
					deal.currency.includes(searchValue))&&
				(deal.crypto == selectedCrypto || selectedCrypto == '' || selectedCrypto == undefined) &&
				(deal.currency == selectedCurrency ||
					selectedCurrency == '' ||
					selectedCurrency == undefined)
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
			if (!cryptos.includes(deal.crypto)) {
				cryptos.push(deal.crypto);
			}
			if (!currencies.includes(deal.currency)) {
				currencies.push(deal.currency);
			}
		}
	}

	function resetValues() {
		selectedCrypto = '';
		selectedCurrency = '';
		searchValue = '';
	}

	async function fetchData() {
		var response = await fetch(`${BACKEND_SERVER}/offers`,{
			headers: {
				'Authorization': `Bearer ${loginToken}`
			},
			body : JSON.stringify({
				"latitude": latitude,
				"longitute": longitude
			})
		})
			.then((response) => response.json());
		console.log(response.data);
		for(var item of response.data){
			if(item.type == view){
				deals.push(item);
				deals[deals.indexOf(item)].chart = "";
			}
		}
		deals.sort(compare);
	}

	/**
	 * @param {{ range: number; }} a
	 * @param {{ range: number; }} b
	 */
	 function compare( a, b){
		if(a.range < b.range){
			return -1;
		}
		if(b.range < a.range){
			return 1;
		}
		return 0;
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
			<div class="row-element">
				<div class="column-element">
					{#await syncCurrencies() then data}
						<Select bind:value={selectedCrypto} label="Crypto">
							{#each currencies as currency}
								<Option value={currency}>{currency}</Option>
							{/each}
						</Select>
					{/await}
				</div>
				<div class="column-element">
					{#await syncCurrencies() then data}
						<Select bind:value={selectedCurrency} label="Currency">
							{#each cryptos as currency}
								<Option value={currency}>{currency}</Option>
							{/each}
						</Select>
					{/await}
				</div>
				<div class="column-element">
					<Textfield bind:value={latitude} label="Latitude" />
				</div>
				<div class="column-element">
					<Textfield bind:value={longitude} label="Longitude" />
				</div>
				<a on:click="{fetchData}">Sort with range<a/>
			</div>
		</div>
	</svelte:fragment>
</Banner>

{#each searchedDeals as deal}
	<Container {deal} color={view == 'BUY' ? 'Blue' : 'Green'} />
{/each}
<br/><br/><br/>
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

	.row-element {
		display: unset;
	}
</style>
