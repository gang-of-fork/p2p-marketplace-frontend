<script lang="ts">
	import Button from '@smui/button';

	import Container from './ContainerGreen.svelte';

	let deals = [
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
</script>

<Button>Inserate bearbeiten</Button>

{#each deals as deal}
	<Container {deal} />
{/each}
