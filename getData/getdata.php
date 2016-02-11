<?php

$itemData = "../resources/itemdata.json";

$string = file_get_contents($itemData);

$array = json_decode($string,true);

get_images($array);


function get_images($array){
	// We get the array and need to download all the images for the items that are combined.
	foreach ( $array['itemdata'] as $itemName=>$itemArray ){
		if ( $itemArray['created'] != false )
		{
			// We get the final Item Name via this.
			$itemPrice = $itemArray['cost'];
			$testPrice = 0;
			// Now we need to get the component names
			$components = $itemArray['components'];
			$componentData = array();
			foreach ( $components as $component ){
				$name = $array['itemdata']["$component"]['dname'];
				$price = $array['itemdata']["$component"]['cost'];
				$componentData[] = array("name"=>$component,"dname"=>$name,"price"=>$price);
				$testPrice += $price;
			}

			if ( $testPrice != $itemPrice ){
				$price = $itemPrice - $testPrice;
				$componentData[] = array("name"=>"recipe","dname"=>"recipe","price"=>$price);
			}
			$print = $itemArray['dname'] . "($itemPrice) = " ;
			foreach ( $componentData as $comp ){
				$print .= $comp['dname'] . "(".$comp['price'].") + ";
			}
			$print = rtrim($print , "+ " );
			echo $print . "\n";
		}
	}
		exit();
}

?>
