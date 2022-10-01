<script lang="ts">
	import Tab, { Label } from '@smui/tab';
	import TabBar from '@smui/tab-bar';
	import Buy from '../../lib/Buy.svelte';
	import Sell from '../../lib/Sell.svelte';
	import Card from '@smui/card';
	import { onMount } from 'svelte';
	import { BACKEND_SERVER } from '../../stores';

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
	let active = tabs[0];
	let size = 24;

	onMount(async () => {
		console.log(await fetch(`${BACKEND_SERVER}/offers`)
			.then((response) => response.json()) )
	});
</script>

<svelte:head>
	<title>Buy</title>
	<meta name="description" content="Buy" />
</svelte:head>

<div>
	<Card style="border-radius:15px; margin: 10px;">
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
		<Buy/>
	{:else}
		<Sell/>
	{/if}
</div>
