<script lang="ts">
	import Button from '@smui/button';

	import Container from './ContainerBlue.svelte';

	let deals = [
		{
			fromCurrency: 'BTC',
			fromAmount: 2,
			toCurrency: 'EUR',
			toAmount: 1,
			range: '2km'
		},
		{
			fromCurrency: 'ETH',
			fromAmount: 7,
			toCurrency: 'EUR',
			toAmount: 2,
			range: '3km'
		},
		{
			fromCurrency: 'CAD',
			fromAmount: 4,
			toCurrency: 'EUR',
			toAmount: 1,
			range: ''
		},
		{
			fromCurrency: 'CAD',
			fromAmount: 3,
			toCurrency: 'EUR',
			toAmount: 1,
			range: ''
		},
		{
			fromCurrency: 'CAD',
			fromAmount: 2,
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
