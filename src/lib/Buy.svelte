<script lang="ts">
	import Button from '@smui/button';
	import Container from './ContainerBlue.svelte';

	let deals = [
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
</script>

<Button>Inserate bearbeiten</Button>

{#each deals as deal}
	<Container {deal} />
{/each}


