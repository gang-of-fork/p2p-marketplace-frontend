<script lang="ts">
	import Button from '@smui/button';

	import Container from './ContainerGreen.svelte';

	let deals = [
		{
			fromCurrency: 'BTC',
			fromAmount: 5,
			toCurrency: 'EUR',
			toAmount: 1,
			range: '1km'
		},
		{
			fromCurrency: 'ETH',
			fromAmount: 3,
			toCurrency: 'EUR',
			toAmount: 2,
			range: ''
		},
		{
			fromCurrency: 'CAD',
			fromAmount: 7,
			toCurrency: 'EUR',
			toAmount: 1,
			range: ''
		},
		{
			fromCurrency: 'CAD',
			fromAmount: 7,
			toCurrency: 'EUR',
			toAmount: 1,
			range: ''
		},
		{
			fromCurrency: 'CAD',
			fromAmount: 7,
			toCurrency: 'EUR',
			toAmount: 1,
			range: ''
		}
	];
</script>

<Button>Inserate bearbeiten</Button>

{#each deals as deal}
	<Container {deal} />
{/each}
