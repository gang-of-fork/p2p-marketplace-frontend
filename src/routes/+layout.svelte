<script>
	import '../app.css';
	import Footer from '../lib/Footer.svelte';
	import Card, { Content } from '@smui/card';
</script>

<main>
	<slot />
</main>

<footer>
	<Card style="background: inherit; border-top-right-radius: 15px; border-top-left-radius: 15px">
	<Footer />
	</Card>
</footer>

<style>
	main {
		text-align: center;
	}

	footer {
		position: fixed;
		bottom: 0;
		text-align: center;
		width: 100%;
		/* From https://css.glass */
		background: rgba(134, 138, 255, 0.2);
		border-radius: 16px;
		box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
		backdrop-filter: blur(6px);
		-webkit-backdrop-filter: blur(6px);
	}

	footer a {
	}
</style>
