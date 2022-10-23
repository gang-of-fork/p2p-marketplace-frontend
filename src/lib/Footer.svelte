<script>
	import Tab, { Icon } from '@smui/tab';
	import TabBar from '@smui/tab-bar';
	import Badge from '@smui-extra/badge';
	import { onMount } from 'svelte/internal';
	import { jwt, BACKEND_SERVER } from '../stores';
	import { goto } from '$app/navigation';

  /**
	 * @type {string}
	 */
	let loginToken;
	jwt.subscribe((value) => {
		loginToken = value;
	});

	let tabs = [
		{
			k: 1,
			icon: 'join_left',
			label: 'Matches',
			route: '/app/matches',
			badge: 0
		},
		{
			k: 2,
			icon: 'home',
			label: 'Home',
			route: '/app/home',
			badge: 0
		},
		{
			k: 3,
			icon: 'menu',
			label: 'Buy and Sell',
			route: '/app/buy',
			badge: 0
		}
	];
	let active = tabs[1];
	let size = 50;

  let matches;

	onMount(async () => {
		if (loginToken == '') {
			goto('/');
		}
		matches = await fetch(`${BACKEND_SERVER}/matches/my`, {
			headers: {
				Authorization: `Bearer ${loginToken}`
			}
		}).then((response) => response.json());
    tabs[0].badge = matches.count;
	});
</script>

<div>
	<TabBar {tabs} let:tab key={(tab) => tab.k} bind:active>
		<Tab
			{tab}
			stacked={true}
			indicatorSpanOnlyContent={true}
			tabIndicator$transition="fade"
			href={tab.route}
		>
			<Icon
				style="font-size: {size}px; margin-left: {24 - size}px; margin-top: {24 - size}px"
				class="material-icons">{tab.icon}</Icon
			>
			{#if tab.badge > 0}
				<Badge
					style="top:20px; left: 0px; background-color: blue;"
					aria-label="unread content count">{tab.badge}</Badge
				>
			{/if}
		</Tab>
	</TabBar>
</div>
