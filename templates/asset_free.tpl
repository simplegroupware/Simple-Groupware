{*
 * @package Simple Groupware
 * @link http://www.simple-groupware.de
 * @copyright Simple Groupware Solutions Thomas Bley 2002-2012
 * @license GPLv2
 *}
{strip}
<script type="text/javascript" src="ext/lib/lightbox/jquery.js"></script>
<script type="text/javascript" src="ext/lib/lightbox/jquery.lightbox-0.5.pack.js"></script>
<link rel="stylesheet" type="text/css" href="ext/lib/lightbox/jquery.lightbox-0.5.css" media="screen" />
<script type="text/javascript">
{literal}
$(function() {
  $("a[@href^=download.php]").filter(function(){ return /jpg|png/i.test(this.href) && !/noinline/.test(this.href); }).lightBox();
});
{/literal}
</script>

{assign var="cols" value=$t.views[$t.view].COLS}
{if $sys.is_mobile}{assign var="cols" value="1"}{/if}

{foreach key=tab_key item=tab_item from=$t.tabs}
{if ($print neq 1 && !$t.disable_tabs) || $tab_key eq "general"}
{if $print eq 1 || $t.disable_tabs}{assign var="tab_key" value=false}{/if}
<div class="tab2 tab2{$tab_key}" {if $tab_key neq "general" && $tab_key}style="display:none;"{/if}>
<table border="0" cellpadding="0" cellspacing="0" style="width:100%; table-layout:fixed;"><tr>
{foreach name=elems key=data_key item=data_item from=$t.data}
{if ceil($smarty.foreach.elems.iteration/$cols) eq ceil($smarty.foreach.elems.total/$cols)}{assign var="last_row" value=1}{/if}
{if $smarty.foreach.elems.iteration>1 && ($smarty.foreach.elems.iteration-1)%$cols eq 0}</tr><tr>{/if}
<td style="{if ($smarty.foreach.elems.iteration)%$cols}padding-right:3px;{/if} {if !$iframe || !$last_row}padding-bottom:4{/if}px;" valign="top">
{if $cycle_dataitem eq "items_even"}{cycle assign="cycle_dataitem" values="items_even,items_odd"}{/if}
<div style="width:100%;" id="_tab_{$tab_key}_{$data_item._id}">
<table cellspacing="0" class="data" style="margin:0px;">
  <tr rel="{$data_item._id}" class="mdown id_header asset_{$data_item._id}" title="{$data_item._id}">
	<td id="pane_close" style="padding:0px; cursor:pointer; display:none;" onclick="top.hidepane(window.name);">&nbsp;x&nbsp;|</td>
    {include file="helper/selitem.tpl"}
	<td class="cursor bold" style="width:100%;"><div style="height:16px; overflow:hidden;">{$data_item[$t.field_1].filter[0]}</div></td>
	{include file="helper/buttons.tpl" style=""}
  </tr>
</table>
<div style="{if $cols neq 1 && !$iframe}height:{$t.views[$t.view].ROW_HEIGHT-22|default:"193px"};{/if} width:100%; overflow:auto;">
<table border="0" cellspacing="0" cellpadding="0" class="data data_page" style="border-top:0px; padding-top:2px; margin:0px; {if $cols neq 1 && !$iframe}height:{$t.views[$t.view].ROW_HEIGHT-22|default:"193px"};{/if}">
  {foreach name=fields key=curr_id item=item from=$data_item}
	{if $t.fields.$curr_id && (!$tab_key || in_array($tab_key,$t.fields.$curr_id.SIMPLE_TAB)) && !$t.fields.$curr_id.HIDDENIN[$t.view] && !$t.fields.$curr_id.HIDDENIN.all}
	  {if $data_item.$curr_id.data[0] neq "" && $curr_id neq $t.field_1}
	    {cycle assign="cycle_dataitem" values="items_even,items_odd"}
        <tr class="{$cycle_dataitem}" style="{$data_item._fgstyle}" valign="top">
		  {include file="helper/data.tpl"}
		  <td {if $data_item._bgstyle}rowspan="2" style="width:20px; {$data_item._bgstyle}"{/if}>&nbsp;</td>
		</tr>
		<tr class="{$cycle_dataitem}">
		  <td style="height:3px;"><div style="height:3px;"></div></td>
		</tr>
	  {/if}
    {/if}
  {/foreach}
</table>
</div>
</div>
</td>
{/foreach}
</tr></table>
</div>
{/if}
{/foreach}
{/strip}

