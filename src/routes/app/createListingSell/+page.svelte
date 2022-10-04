<script>
	import { onMount } from 'svelte';
	import { BACKEND_SERVER, jwt } from '../../../stores';
	import { goto } from '$app/navigation';

	/**
	 * @type {string}
	 */
	let loginToken;
	jwt.subscribe((value) => {
		loginToken = value;
	});




</script>
<svelte:head
>
	<title>createListingSell</title>
	<meta name="description" content="createListingSell" />
</svelte:head>

<h1>Create Listing Sell</h1>

