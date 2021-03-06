#!/usr/bin/haserl
<?
	# This program is copyright � 2008-2010 Eric Bishop and is distributed under the terms of the GNU GPL 
	# version 2.0 with a special clarification/exception that permits adapting the program to 
	# configure proprietary "back end" software provided that all modifications to the web interface
	# itself remain covered by the GPL. 
	# See http://gargoyle-router.com/faq.html#qfoss for more information
	eval $( gargoyle_session_validator -c "$COOKIE_hash" -e "$COOKIE_exp" -a "$HTTP_USER_AGENT" -i "$REMOTE_ADDR" -r "login.sh" -t $(uci get gargoyle.global.session_timeout) -b "$COOKIE_browser_time"  )	
	gargoyle_header_footer -h -s "status" -p "webmon" -c "internal.css" -j "webmon.js table.js" -n webmon_gargoyle gargoyle
?>


<script>
<!--
<?
	webmon_enabled=$(ls /etc/rc.d/*webmon_gargoyle* 2>/dev/null)
	if [ -n "$webmon_enabled" ] ; then
		echo "var webmonEnabled=true;"
	else
		echo "var webmonEnabled=false;"
	fi

?>
//-->
</script>


<form>
	<fieldset>
		<legend class="sectionheader">Web Monitor Preferences</legend>
		<div>
			<input type='checkbox' id='webmon_enabled' onclick="setWebmonEnabled()" />
			<label id='webmon_enabled_label' for='webmon_enabled'>Enable Web Usage Monitor</label>
		</div>
		<div class="indent">
			<div>
				<label class='leftcolumn' for='num_domains' id='num_domains_label'>Number of Sites to Save:</label>
				<input type='text' class='rightcolumn' id='num_domains' onkeyup='proofreadNumericRange(this,1,9999)' size='6' maxlength='4' />
			</div>
			<div>
				<label class='leftcolumn' for='num_searches' id='num_searches_label'>Number of Searches to Save:</label>
				<input type='text' class='rightcolumn' id='num_searches' onkeyup='proofreadNumericRange(this,1,9999)' size='6' maxlength='4' />
			</div>
			<div>
				<select id="include_exclude" onchange="setIncludeExclude()">
					<option value="all">Monitor All Hosts</option>
					<option value="include">Monitor Only Hosts Below</option>
					<option value="exclude">Exclude Hosts Below From Monitoring</option>
				</select>
			</div>
			<div class='indent' id="add_ip_container">
				<div>
					<input type='text' id='add_ip' onkeyup='proofreadMultipleIps(this)' size='30' />
					<input type="button" class="default_button" id="add_ip_button" value="Add" onclick="addAddressesToTable(document, 'add_ip', 'ip_table_container', 'ip_table', false, 3, 1, 250)" />
					<br/>
					<em>Specify IP or IP Range</em>
				</div>
				<div id="ip_table_container"></div>
			</div>
		</div>

		
		<div class="internal_divider"></div>

		<div id="bottom_button_container">
			<input type='button' value='Save Changes' id="save_button" class="default_button" onclick='saveChanges()' />
			<input type='button' value='Reset' id="reset_button" class="default_button" onclick='resetData()'/>
			<input type='button' value='Clear History' id="clear_history" class="default_button" onclick='clearHistory()'/>
		</div>
	</fieldset>
	<fieldset>
		<legend class="sectionheader">Recently Visited Sites</legend>
		<div>
			<select id="domain_host_display" onchange="updateMonitorTable()">
				<option value="hostname">Display Hostnames</option>
				<option value="ip">Display Host IPs</option>
			</select>
		</div>

		<div id="webmon_domain_table_container"></div>
	</fieldset>

	<fieldset>
		<legend class="sectionheader">Recent Web Searches</legend>
		<div>
			<select id="search_host_display" onchange="updateMonitorTable()">
				<option value="hostname">Display Hostnames</option>
				<option value="ip">Display Host IPs</option>
			</select>
		</div>

		<div id="webmon_search_table_container"></div>
	</fieldset>


	<fieldset id="download_web_usage_data" >
		<legend class="sectionheader">Download Web Usage Data</legend>
		<div>
			<span style='text-decoration:underline'>Data is comma separated:</span>
			<br/>
			<em>[Time of Last Visit],[Local IP],[Domain Visted/Search Request]</em>
			<br/>
		</div>
		<div>
			<center>
				<input type='button' id='download_domain_button' class='big_button' value='Visited Sites' onclick='window.location="webmon_domains.csv";' />
				&nbsp;&nbsp;
				<input type='button' id='download_search_button' class='big_button' value='Search Requests' onclick='window.location="webmon_searches.csv";' />
			</center>
		</div>
	</fieldset>
</form>

<!-- <br /><textarea style="margin-left:20px;" rows=30 cols=60 id='output'></textarea> -->


<script>
<!--
	resetData();
//-->
</script>


<?
	gargoyle_header_footer -f -s "status" -p "webmon"
?>
