<script>
	// @ts-ignore
	import PickAPlace from 'svelte-pick-a-place';
	import leaflet from 'leaflet';

</script>

<PickAPlace
	leaflet={leaflet}
	on:update={() => console.log('Update!')}
	on:save={() => console.log('On save!')}
/>
