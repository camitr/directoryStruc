<?php

if(isset($_POST['drive'])){

	$servername = "10.129.200.50";
	$username = "root";
	$password = "123";
$dbname = "dirstruc";

$output = shell_exec("df -h ".$_POST['drive']." | awk ' FNR == 2 {print $1 \",\" $2 \",\" $3 \",\"$4 \",\"$5}'");

$disk_info_arr=explode(",", $output);

echo "$output";

$output = shell_exec(" /sbin/udevadm info --query=property --name=".$disk_info_arr[0]."| grep '^ID_SERIAL_SHORT\|^ID_VENDOR='|awk -F '=' '{print $2}'| paste -d, -s");

$disk_meta_info=explode(",", $output);

echo "$output";

$list=explode("@", $output);
foreach ($list as &$value) {
				$arr	= explode(",", $value);


				}	
}

# regex with white spaces
$output = shell_exec("mount| grep /media/|awk '{print $3 \"\ \"$4 \"@\"}'| sed 's/\\\ type/ /'");

$list=explode("@", $output);


?>
<html>
<body>
<form action="<?php echo $_SERVER["PHP_SELF"] ?>" method="post">
	<select name="drive">
	<option val="1">Select Drive</option>
		<?php foreach ($list as &$value) {
			$Dname=explode("/", $value);
     echo '<option value="'.$value.'">'.$Dname[sizeof($Dname)-1].'</option>';

		}?>

    
	</select>
   <input type="submit" value="Submit data" >
   </form>
</body>
</html>
