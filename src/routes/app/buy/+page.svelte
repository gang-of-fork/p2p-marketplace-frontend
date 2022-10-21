<script>
	import Tab, { Label } from '@smui/tab';
	import TabBar from '@smui/tab-bar';
	import Inserate from '../../../lib/Inserate.svelte';
	import Card from '@smui/card';
	import { onMount } from 'svelte';
	import { BACKEND_SERVER, jwt } from '../../../stores';
	import { goto } from '$app/navigation';
	import { env } from '$env/dynamic/private';

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
			_id: '',
			crypto: 'BTC',
			currency: 'GBP',
			location: [0,0],
			name: 'Morus alba',
			range: 0,
			cryptoAmount: 0,
			currencyAmount: 0,
			chart: ''
		}
	];

	let sellDeals = [
		{
			_id: '',
			crypto: 'BTC',
			currency: 'GBP',
			location: [0,0],
			name: 'Morus alba',
			range: 0,
			cryptoAmount: 0,
			currencyAmount: 0,
			chart: ''
		}
	];

	let active = tabs[0];
	let size = 24;

	onMount(async () => {
		if (loginToken == '') {
			goto('/');
		};
	});


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
		<Inserate view="BUY"/>
	{:else}
		<Inserate view="SELL"/>
	{/if}
</div>
