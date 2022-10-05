<script>
	import { dataset_dev } from 'svelte/internal';
	import {jwt, BACKEND_SERVER} from '../../../stores';
	import { onMount } from 'svelte';


	onMount(async () => {
		console.log(await fetch(`${BACKEND_SERVER}/offers`)
			.then((response) => response.json())
			.then((response) => response.data.name))
	});
</script>
<svelte:head
>
	<title>createListingSell</title>
	<meta name="description" content="createListingSell" />
</svelte:head>

<h1>Create Listing Sell</h1>