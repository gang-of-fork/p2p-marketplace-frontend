<script>
	import { page } from '$app/stores';
</script>

<svelte:head>
	<title>Home</title>
	<meta name="description" content="Svelte demo app" />
</svelte:head>

<section>
	<h2>Arbeiten an:</h2>
	<li class:active={$page.url.pathname === '/'}>
        <a href="/">Home</a>
    </li>
    <li class:active={$page.url.pathname === '/'}>
        <a href="/buy">Buy</a>
    </li>
    <li class:active={$page.url.pathname === '/'}>
        <a href="/deal">Deal</a>
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
