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
      </Tab>
    </TabBar>
  </div>
   
  <script lang="ts">
    import Tab, { Icon, Label } from '@smui/tab';
    import TabBar from '@smui/tab-bar';
   
    let tabs = [
      {
        k: 1,
        icon: 'person',
        label: 'Account',
        route: '/userInfo'
      },
      {
        k: 2,
        icon: 'home',
        label: 'Home',
        route: '/'
      },
      {
        k: 3,
        icon: 'menu',
        label: 'Buy and Sell',
        route: '/buy'
      },
    ];
    let active = tabs[2];
    let size = 50;
  </script>