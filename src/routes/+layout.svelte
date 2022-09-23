<script>
	import '../app.css';
	import Footer from '../lib/Footer.svelte';
</script>



<main>
	<slot />
</main>

<footer>
	<Footer />
</footer>


<style>
	main {
		text-align: center;
	}

	footer {
		position: absolute;
		bottom: 0;
		text-align: center;
		width: 100%;
		
	}

	footer a {
		
	}


</style>
