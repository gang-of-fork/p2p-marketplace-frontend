<div>
    <TabBar {tabs} let:tab key={(tab) => tab.k} bind:active>
      <Tab
        {tab}
        stacked={true}
        indicatorSpanOnlyContent={true}
        tabIndicator$transition="fade"
        href={tab.route}
      >
        <Icon style="font-size: {size}px; margin-left: {24-size}px; margin-top: {24-size}px" class="material-icons">{tab.icon}</Icon>
        {#if tab.badge}
        <Badge style="top:20px; left: 0px; background-color: blue;" aria-label="unread content count">2</Badge>
        {/if}
      </Tab>
    </TabBar>
  </div>
   
  <script lang="ts">
    import Tab, { Icon } from '@smui/tab';
    import TabBar from '@smui/tab-bar';
    import Badge from '@smui-extra/badge';
   
    let tabs = [
      {
        k: 1,
        icon: 'join_left',
        label: 'Account',
        route: '/app/matchings',
        badge: true
      },
      {
        k: 2,
        icon: 'home',
        label: 'Home',
        route: '/app/home',
        badge: false
      },
      {
        k: 3,
        icon: 'menu',
        label: 'Buy and Sell',
        route: '/app/buy',
        badge: false
      },
    ];
    let active = tabs[1];
    let size = 50;
  </script>