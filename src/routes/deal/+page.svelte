<script lang="ts">
	import Card, { Content } from '@smui/card';
	import ImageList, {
		Item,
		ImageAspectContainer,
		Image,
		Supporting,
		Label
	} from '@smui/image-list';
	import Fab from '@smui/fab';

	import Chip, { Set, Text } from '@smui/chips';
	import Button from '@smui/button';

	export let deal = {
		fromCurrency: 'ERR',
		fromAmount: -1,
		toCurrency: 'ERR',
		toAmount: -1,
		range: '1km'
	};
</script>

<svelte:head>
	<title>Sell</title>
	<meta name="description" content="Sell" />
</svelte:head>

<div class="card">
	<Card class="card" padded style="border-radius:15px;">
		<div class="container" style="margin-top: 50px;">
			<div class="row-element">
				<div class="row-element" style="flex: 1">
					<Fab style="background-color: transparent; box-shadow: none;">
					</Fab>
				</div>
				<div style="margin-bottom: -15px;">
					<div class="row-element">
						<Set chips={[deal.fromCurrency]} let:chip nonInteractive>
							<Chip {chip} style="background-color: #018786;">
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
			</div>
		</div>
	</Card>
</div>

<div class="card">
	<Card class="card" padded style="border-radius:15px;">
		<div class="container" style="margin-bottom: 50px;">
			<div class="row-element">
				<div>
					<div class="row-element">
						<h1 style="margin-right: 8px;">{deal.toAmount}</h1>
					</div>
					<div class="row-element">
						<i class="material-icons"> arrow_forward </i>
					</div>
					<div class="row-element">
						<h1 style="margin-left: 8px;">{deal.fromAmount}</h1>
					</div>
				</div>
				<div style="margin-top: -15px;">
					<div class="row-element">
						<Set chips={[deal.toCurrency]} let:chip nonInteractive>
							<Chip {chip} style="background-color: #6200ee;">
								<Text><span style="color: white;">{chip}</span></Text>
							</Chip>
						</Set>
					</div>
					<div class="row-element">
						<Set chips={[deal.fromCurrency]} let:chip nonInteractive>
							<Chip {chip}>
								<Text>{chip}</Text>
							</Chip>
						</Set>
					</div>
				</div>
				<div class="row-element" style="flex: 1">
						<Fab style="background-color: #6200ee">
							{deal.range}
						</Fab>
				</div>
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
