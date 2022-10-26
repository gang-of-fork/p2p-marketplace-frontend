<script>
	import Button from '@smui/button';

</script>

<svelte:head>
	<title>home</title>
	<meta name="description" content="home" />
</svelte:head>

<h1 class="body">Inserate erstellen</h1>

<div style="text-align:center; height: 500px">
	<Button
		variant="unelevated"
		color="primary"
		style="width: 80%; margin: 20px; height: 40%; font-size: 30px"
		href="/app/createListingSell"

	>
		<p>Verkaufen</p>
	</Button>
	<Button
		variant="unelevated"
		href="/app/createListingBuy"
		style="width: 80%; 
		margin: 20px; 
		height: 40%; 
		background-color: var(--tertiary-color) !important;
		font-size: 30px; 
"
	>
		<p>Kaufen</p>
	</Button>
</div>

<style>
	.body {
		background-color: #181b20;
	}
</style>
