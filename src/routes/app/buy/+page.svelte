<script>
	import Tab, { Label } from '@smui/tab';
	import TabBar from '@smui/tab-bar';
	import Inserate from '../../../lib/Inserate.svelte';
	import Card from '@smui/card';
	import { onMount } from 'svelte';
	import { BACKEND_SERVER, jwt } from '../../../stores';
	import { goto } from '$app/navigation';

	/**
	 * @type {string}
	 */
	let loginToken;
	jwt.subscribe((value) => {
		loginToken = value;
	});

	let tabs = [
		{
			k: 1,
			label: 'Kaufen'
		},
		{
			k: 2,
			label: 'Verkaufen'
		}
	];

	let buyDeals = [
		{
			fromCurrency: 'BTC',
			fromAmount: 2,
			toCurrency: 'EUR',
			toAmount: 1,
			range: '2km',
			chart: ''
		},
		{
			fromCurrency: 'ETH',
			fromAmount: 7,
			toCurrency: 'EUR',
			toAmount: 2,
			range: '3km',
			chart: ''
		},
		{
			fromCurrency: 'ADA',
			fromAmount: 4,
			toCurrency: 'EUR',
			toAmount: 1,
			range: '',
			chart: ''
		},
		{
			fromCurrency: 'ADA',
			fromAmount: 3,
			toCurrency: 'USDT',
			toAmount: 1,
			range: '',
			chart: ''
		},
		{
			fromCurrency: 'ADA',
			fromAmount: 2,
			toCurrency: 'GBP',
			toAmount: 1,
			range: '',
			chart: ''
		}
	];

	let sellDeals = [
		{
			fromCurrency: 'BTC',
			fromAmount: 5,
			toCurrency: 'EUR',
			toAmount: 1,
			range: '1km',
			chart: ''
		},
		{
			fromCurrency: 'ETH',
			fromAmount: 3,
			toCurrency: 'EUR',
			toAmount: 2,
			range: '',
			chart: ''
		},
		{
			fromCurrency: 'ADA',
			fromAmount: 7,
			toCurrency: 'EUR',
			toAmount: 1,
			range: '',
			chart: ''
		},
		{
			fromCurrency: 'ADA',
			fromAmount: 7,
			toCurrency: 'USDT',
			toAmount: 1,
			range: '',
			chart: ''
		},
		{
			fromCurrency: 'ADA',
			fromAmount: 7,
			toCurrency: 'EUR',
			toAmount: 1,
			range: '',
			chart: ''
		}
	];

	let active = tabs[0];
	let size = 24;

	onMount(async () => {
		if (loginToken == '') {
			goto('/');
		};
		console.log(await fetch(`${BACKEND_SERVER}/offers`,{
			headers: {
				'Authorization': `Bearer ${loginToken}`
			}
		})
			.then((response) => response.json()) )
	});
</script>

<svelte:head>
	<title>Buy</title>
	<meta name="description" content="Buy" />
</svelte:head>

<div>
	<Card class="noHover" style="border-radius:15px; margin: 10px;">
	<TabBar {tabs} let:tab key={(tab) => tab.k} bind:active>
		<Tab
			{tab}
			stacked={true}
			indicatorSpanOnlyContent={true}
			tabIndicator$transition="fade"
			href={tab.route}
			on:click={() => (active = tab)}
		>
			<Label style="font-size: {size}px; margin-left: {24 - size}px; margin-top: {24 - size}px"
				>{tab.label}</Label
			>
		</Tab>
	</TabBar>
	</Card>
	{#if active.k == 1}
		<Inserate view="Buy" deals={buyDeals}/>
	{:else}
		<Inserate view="Sell" deals={sellDeals}/>
	{/if}
</div>
