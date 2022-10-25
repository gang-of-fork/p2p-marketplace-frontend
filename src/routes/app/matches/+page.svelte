<script>
	import { jwt, BACKEND_SERVER } from '../../../stores';
	import { onMount } from 'svelte';
	import { goto } from '$app/navigation';
	import ContainerMatches from '$lib/ContainerMatches.svelte';

	import Button from '@smui/button';

	let matches;
	/**
	 * @type {any}
	 */
	let offers = [];
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
		matches = await fetch(`${BACKEND_SERVER}/matches/my`, {
			headers: {
				Authorization: `Bearer ${loginToken}`
			}
		}).then((response) => response.json());
		console.log(matches);
		for (var match of matches.data) {
			let offer = await fetch(`${BACKEND_SERVER}/matches/${match._id}`, {
				headers: {
					Authorization: `Bearer ${loginToken}`
				}
			}).then((response) => response.json());
			console.log(offer);
			offers.push({ offer: offer, match: match });
		}
	});
</script>

<svelte:head>
	<title>Matches</title>
	<meta name="description" content="matches" />
</svelte:head>

<h1>My Matches</h1>
{#each offers as offer}
	<ContainerMatches deal={offer} />
{/each}
