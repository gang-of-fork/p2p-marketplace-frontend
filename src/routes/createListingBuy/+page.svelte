<script>
	import Card from '@smui/card';
	import LayoutGrid, { Cell } from '@smui/layout-grid';
	import Paper, { Title, Subtitle, Content } from '@smui/paper';
	import Select, { Option } from '@smui/select';
	import Slider from '@smui/slider';
	import Button from '@smui/button';


	let currencies = ['EUR', 'USD', 'CAD', 'CNY', 'GBP', 'JPY', 'CHF'];
	let cryptoCurrencies = ['BTC', 'ETH', 'DOGE'];
	let fruits = ['BTC', 'ETH', 'DOGE'];

	let valueCurrency = '';
	let valueCrypto = '';
	let valueStart = 400;
	let valueEnd = 500;
	let valueRange = 0;
	let inputFieldStart;
	let inputFieldEnd;
	const currencyRangeMin = 0;
	const currencyRangeMax = 1000;
	let selectedColor = "#76c283";
	let defaultColor = "#333333"
	let circle1Color = defaultColor;
	let circle2Color = defaultColor;
	let circle3Color = defaultColor;
	

	function valueRangeChange(){
		if(valueRange > 100){
			circle1Color = selectedColor;
			circle2Color = defaultColor;
			circle3Color = defaultColor;
		}else if (valueRange > 50){
			circle1Color = defaultColor;
			circle2Color = selectedColor;
			circle3Color = defaultColor;
		}else{
			circle1Color = defaultColor;
			circle2Color = defaultColor;
			circle3Color = selectedColor;
		}
	}
</script>

<svelte:head>
	<title>Create Listing Buy</title>
	<meta name="description" content="Create Listing Buy" />
</svelte:head>

<body>
	<h1>Create Listing Buy</h1>

	<LayoutGrid fixedColumnWidth>
		<Cell span={12}>
			<Paper color="custom-black">
				<Title>Kaufgeschäft</Title>
				<Subtitle>Mit welchen Währungen möchtest du handeln?</Subtitle>

				<Content>
					<Cell span={1}>
						<div class="cell">
							<div style="padding: 10px">
								<Select
									class="shaped-outlined"
									variant="outlined"
									bind:value={valueCurrency}
									label="Currencies"
								>
									<Option value="" />
									{#each currencies as currency}
										<Option value={currency}>{currency}</Option>
									{/each}
								</Select>
							</div>
							<div>
								<Select
									class="shaped-outlined"
									variant="outlined"
									bind:value={valueCrypto}
									label="Crypto Currencies"
								>
									<Option value="" />
									{#each cryptoCurrencies as cryptoCurrency}
										<Option value={cryptoCurrency}>{cryptoCurrency}</Option>
									{/each}
								</Select>
							</div>
						</div>
					</Cell>
					<Cell span={1}>
						<p>2</p>
					</Cell>
				</Content>
			</Paper>
		</Cell>
		<Cell span={12}>
			<Paper class="paper">
				<Title>Kaufpreis</Title>
				<Content>
					<div class="cell">
						<Slider
							range
							bind:start={valueStart}
							bind:end={valueEnd}
							min={currencyRangeMin}
							max={currencyRangeMax}
							step={0.1}
							input$aria-label="Range slider"
						/>
					</div>
					<div style="text-align:center">
						<input
							bind:value={valueStart}
							class="inputFields"
							type="number"
							min={currencyRangeMin}
							max={valueEnd}
						/>
						<input
							bind:value={valueEnd}
							class="inputFields"
							type="number"
							min={valueStart}
							max={currencyRangeMax}
						/>
						<!--
						<Textfield bind:value={valueStart} label="Startwert" type="number" input$step="0.5" />
						<Textfield bind:value={valueEnd} label="Endwert" type="number" input$step="0.5" />
						-->
					</div>
				</Content>
			</Paper>
		</Cell>
		<Cell span={12}>
			<Paper>
				<Title>Umkreis</Title>
				<Content>
					<div class="rangeDiv" style="vertical-align: middle;">
						<div style="width: 10px; margin-top: 4rem; display:inline-block; float:left; 
						">
							<div class="input_wrapper">
								<input bind:value={valueRange} class="inputFields" type="number" min={0} on:change={valueRangeChange} />
								<div class="unit">km</div>
							</div>
						</div>
						<div class="circlesRange" style="width: 150px; margin-right: 1em;  display:inline-block;">
							<div class="circle circle1" style="background-color: {circle1Color}">
								<div class="circle circle2" style="background-color: {circle2Color}">
									<div class="circle circle3" style="background-color: {circle3Color}"/>
								</div>
							</div>
						</div>
					</div>
				</Content>
			</Paper>
		</Cell>
		<Cell span={12}>
			<div class="buttonNav">

				<Button variant="outlined" href="/home" >Back</Button>
				<Button variant="raised" href="/buy">Search</Button>

			</div>
		</Cell>
		<Cell>
			<br/>
			<br/>
			<br/>
			<br/>
			<br/>
			
		</Cell>
	</LayoutGrid>
</body>

<style>
	body {
		width: 100%;
		height: 100%;
	}

	input {
		font-size: 14px;
		padding: 10px 25px 10px 10px;
		border: 1px solid #ccc;
	}

	.input_wrapper {
		float: left;
		position: relative;
	}

	.input_wrapper .unit {
		position: absolute;
		right: 15px;
		top: 7px;
		color: #999;
	}

	.circlesRange {
		float: right;
	}

	.circle {
		background-color: #333333;
		display: flex;
		justify-content: center;
		text-align: center;
		align-items: center;
		align-content: center;
		border-color: black;
		border-width: 2px;
		border-style: solid;
	}

	.circle1 {
		width: 150px;
		height: 150px;
		-webkit-border-radius: 75px;
		-moz-border-radius: 75px;
		border-radius: 75px;
	}

	.circle2 {
		width: 100px;
		height: 100px;
		-webkit-border-radius: 50px;
		-moz-border-radius: 50px;
		border-radius: 50px;
	}

	.circle3 {
		width: 50px;
		height: 50px;
		-webkit-border-radius: 25px;
		-moz-border-radius: 25px;
		border-radius: 25px;
	}

	.inputFields {
		width: 80px;
		text-align: center;
	}

	.rangeDiv {
		overflow: hidden;
	}

	.rangeDiv::after {
		clear: both;
		display: block;
	}

	.paper {
		background-color: black;
	}

	h1 {
		color: white;
	}

	.cell {
		width: 100%;
		text-align: center;
	}

	* :global(.shaped-outlined),
	* {
		border-radius: 28px;
		margin: 3px;
	}

	* :global(.shaped-outlined .mdc-text-field__input) {
		padding-left: 32px;
		padding-right: 0;
	}

	* :global(.shaped-outlined .mdc-notched-outline .mdc-notched-outline__leading) {
		border-radius: 28px 0 0 28px;
		width: 28px;
	}

	* :global(.shaped-outlined .mdc-notched-outline .mdc-notched-outline__trailing) {
		border-radius: 0 28px 28px 0;
	}

	* :global(.shaped-outlined .mdc-notched-outline .mdc-notched-outline__notch) {
		max-width: calc(100% - 28px * 2);
	}
</style>