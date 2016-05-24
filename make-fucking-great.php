<?php
	function getDataFromDir($directory){
		$result = array(
			'name'=>'',
			'title'=>'',
			'problem'=>'',
			'script'=>'',
			'output'=>'',
		);



		$problem_file = @file_get_contents($directory.'/problem.txt');
		$script_file = @file_get_contents($directory.'/script.sh');
		$output_file = @file_get_contents($directory.'/output.txt');


		$problem_lines = explode("\n", $problem_file);

		$title = preg_replace('/^h1\.\s*/', '', $problem_lines[0]);

		$problem_lines[0] = '';

		$problem_tmp = implode("\n", $problem_lines);
		$problem_tmp = trim($problem_tmp);


		$result['name'] = basename($directory);
		$result['title'] = $title;
		$result['problem']  = $problem_tmp;
		$result['script'] = $script_file;
		$result['output'] = $output_file;

// var_dump($result);
		return $result;
	}


?><!DOCTYPE html>
<html>
<head>
	<title></title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.4.0/highlight.min.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.4.0/languages/bash.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.4.0/styles/default.min.css">
	 <script>hljs.initHighlightingOnLoad();</script>
	<style>
		body {
			/*font-size: 12pt;*/
			line-height: 1em;
		}

		.output pre{
		    display: block;
		    overflow-x: auto;
		    padding: 0.5em;
		    background: #F0F0F0;			
		    color: #444;
		}
	</style>
</head>
<body>
	<h1>Bash скрипти</h1>


	<?php
		$order = array(
			'1',
			'2',
			'3',
			'4',
			'5',
			'6',
			'7',
			'8',
			'9',
			'10',
			'11',
			'12',
			'13',
			'14',
			'15',
			'16',
			'17',
			'18',
			'19',
			'20',
			'21',
			'22',
			// '23',
			// '24',
			// '25',
			// '26',
			// '27',
			// '28',
			// '29',

		);
		$results = array();

		$dir = "./bash-examples/";
		$dir = "/var/www/html/bash-examples/";
		$dh  = opendir($dir);
		while (false !== ($filename = readdir($dh))) {
		    //$filename;
		    if(is_dir($filename)){
		    	$example = getDataFromDir($dir.$filename);
		    	$results[$example['name']] = $example;


		    	// var_dump($filename);
		    	// var_dump($example);
		    	// echo '<br/>';
		    }
		}	


		foreach ($order as $key => $value){
			$example = $results[$value];
	?>

		<article class="example" id="example-<?=htmlspecialchars($example['name']);?>">
			<h3><?=htmlspecialchars($example['name']);?>. <?=htmlspecialchars($example['title']);?></h3>
			<p class="problem">
				<?=nl2br(htmlspecialchars($example['problem']));?>
			</p>
			<br/>
			<i>script.sh</i>
			<div class="script">
				<pre><code class="bash"><?=htmlspecialchars($example['script']);?></code></pre>
			</div>
			<br/>
			<i>Вивід</i>
			<div class="output">
				<pre><?=htmlspecialchars($example['output']);?></pre>
			</div>
		</article>
	<?php			
		}

	?>

</body>
</html>