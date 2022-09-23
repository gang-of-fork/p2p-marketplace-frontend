<script>
	import Counter from '$lib/Counter.svelte';
	import { page } from '$app/stores';
</script>

<svelte:head>
	<title>Home</title>
	<meta name="description" content="Svelte demo app" />
</svelte:head>

<section>
	<h2>Arbeiten an:</h2>
	<li class:active={$page.url.pathname === '/'}>
        <a href="/home">Home</a>
    </li>
    <li class:active={$page.url.pathname === '/'}>
        <a href="/buy">Buy</a>
    </li>
    <li class:active={$page.url.pathname === '/'}>
        <a href="/sell">Sell</a>
    </li>
    <li class:active={$page.url.pathname === '/'}>
        <a href="/createListingBuy">CreateListingBuy</a>
    </li>
    <li class:active={$page.url.pathname === '/'}>
        <a href="/createListingSell">CreateListingSell</a>
    </li>
    <li class:active={$page.url.pathname === '/'}>
        <a href="/login">Login</a>
    </li>
    <li class:active={$page.url.pathname === '/'}>
        <a href="/userInfo">UserInfo</a>
    </li>
</section>

<style>
	
</style>
