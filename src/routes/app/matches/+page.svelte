<script>
	import { jwt, BACKEND_SERVER } from '../../../stores';
	import { onMount } from 'svelte';
	import { goto } from '$app/navigation';
	import ContainerMatches from '$lib/ContainerMatches.svelte';

	import Button from '@smui/button';

	/**
	 * @type {any[]}
	 */
	let matches = [];
	/**
	 * @type {string}
	 */
	let loginToken;
	jwt.subscribe((value) => {
		loginToken = value;
	});
	onMount(async () => {
		if (loginToken == '') {
			goto('/');
		}
		const response = await fetch(`${BACKEND_SERVER}/matches/my`, {
			headers: {
				Authorization: `Bearer ${loginToken}`
			}
		}).then((response) => (response.json()));
		matches = response.data;
		console.log(matches);
	});
</script>

<svelte:head>
	<title>Matches</title>
	<meta name="description" content="matches" />
</svelte:head>

<h1>My Matches</h1>
{#each matches as match}
	<ContainerMatches {match} />
{/each}
