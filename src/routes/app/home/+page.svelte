<script>
	import Button from '@smui/button';

	let clicked = 0;
</script>

<svelte:head>
	<title>home</title>
	<meta name="description" content="home" />
</svelte:head>

<h1 class="body">Home 1</h1>

<div style="text-align:center; height: 500px">
	<Button
		on:click={() => clicked++}
		variant="unelevated"
		color="primary"
		style="width: 80%; margin: 20px; height: 40%"
		href="/app/createListingSell"

	>
		<p>Sell</p>
	</Button>
	<Button
		on:click={() => clicked++}
		variant="unelevated"
		color="primary"
		style="width: 80%; margin: 20px; height: 40%"
		href="/app/createListingBuy"
	>
		<p>Buy</p>
	</Button>
</div>

<style>
	.body {
		background-color: #181b20;
	}
</style>
