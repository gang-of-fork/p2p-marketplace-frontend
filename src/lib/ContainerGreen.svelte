<script lang="ts">
	import Card from '@smui/card';
	import { Image } from '@smui/image-list';
	import Fab from '@smui/fab';

	import Chip, { Set, Text } from '@smui/chips';

	export let deal = {
		fromCurrency: 'ERR',
		fromAmount: -1,
		toCurrency: 'ERR',
		toAmount: -1,
		range: ''
	};
</script>

<div class="card">
	<Card class="card" padded style="border-radius:15px;">
		<div class="container">
			<div class="row-element">
				<div>
					<div class="row-element">
						<h1 style="margin-right: 8px;">{deal.fromAmount}</h1>
					</div>
					<div class="row-element">
						<i class="material-icons"> arrow_forward </i>
					</div>
					<div class="row-element">
						<h1 style="margin-left: 8px;">{deal.toAmount}</h1>
					</div>
				</div>
				<div style="margin-top: -15px;">
					<div class="row-element">
						<Set chips={[deal.fromCurrency]} let:chip nonInteractive>
							<Chip {chip} style="background-color: #018786">
								<Text><span style="color: white;">{chip}</span></Text>
							</Chip>
						</Set>
					</div>
					<div class="row-element">
						<Set chips={[deal.toCurrency]} let:chip nonInteractive>
							<Chip {chip}>
								<Text>{chip}</Text>
							</Chip>
						</Set>
					</div>
				</div>
			</div>

			<div class="row-element" style="flex: 1">
				{#if deal.range != ''}
					<Fab href="/deal">
						{deal.range}
					</Fab>
				{/if}
			</div>

			<div class="row-element">
				<Image style="max-width: 75px" src="https://img.icons8.com/plasticine/400/stocks.png" />
			</div>
		</div>
	</Card>
</div>

<style>
	.row-element {
		display: inline-block;
		margin: auto;
	}

	.container {
		display: flex;
	}

	.card {
		margin: 10px;
	}
</style>
