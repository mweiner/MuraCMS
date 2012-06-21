<!--- This file is part of Mura CMS.

Mura CMS is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, Version 2 of the License.

Mura CMS is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Mura CMS. If not, see <http://www.gnu.org/licenses/>.

Linking Mura CMS statically or dynamically with other modules constitutes the preparation of a derivative work based on 
Mura CMS. Thus, the terms and conditions of the GNU General Public License version 2 ("GPL") cover the entire combined work.

However, as a special exception, the copyright holders of Mura CMS grant you permission to combine Mura CMS with programs
or libraries that are released under the GNU Lesser General Public License version 2.1.

In addition, as a special exception, the copyright holders of Mura CMS grant you permission to combine Mura CMS with 
independent software modules (plugins, themes and bundles), and to distribute these plugins, themes and bundles without 
Mura CMS under the license of your choice, provided that you follow these specific guidelines: 

Your custom code 

• Must not alter any default objects in the Mura CMS database and
• May not alter the default display of the Mura CMS logo within Mura CMS and
• Must not alter any files in the following directories.

 /admin/
 /tasks/
 /config/
 /requirements/mura/
 /Application.cfc
 /index.cfm
 /MuraProxy.cfc

You may copy and distribute Mura CMS with a plug-in, theme or bundle that meets the above guidelines as a combined work 
under the terms of GPL for Mura CMS, provided that you include the source code of that other code when and as the GNU GPL 
requires distribution of source code.

For clarity, if you create a modified version of Mura CMS, you are not obligated to grant this special exception for your 
modified version; it is your choice whether to do so, or to make such modified version available under the GNU General Public License 
version 2 without this exception.  You may, if you choose, apply this exception to your own modified versions of Mura CMS.
--->

<cfset subType=application.classExtensionManager.getSubTypeByID(rc.subTypeID)>
<cfset extendSetBean=subType.loadSet(rc.extendSetID) />
<h2><cfif len(rc.extendSetID)>Edit<cfelse>Add</cfif> Attribute Set</h2>
<cfoutput>
	
<ul class="metadata">
<li><strong>Class Extension:</strong> #application.classExtensionManager.getTypeAsString(subType.getType())# / #subType.getSubType()#</li>
</ul>

<ul class="navTask nav nav-pills">
<li><a href="index.cfm?muraAction=cExtend.listSubTypes&siteid=#URLEncodedFormat(rc.siteid)#">Class Extension Manager</a></li>
<li><a href="index.cfm?muraAction=cExtend.listSets&subTypeID=#rc.subTypeID#&siteid=#URLEncodedFormat(rc.siteid)#">Back to Attribute Sets</a></li>
</ul>


<form novalidate="novalidate" name="form1" method="post" action="index.cfm" onsubit="return validateForm(this);">
<dl class="oneColumn separate">
<dt class="first">Attribute Set Name</dt>
<dd><input name="name" value="#HTMLEditFormat(extendSetBean.getName())#" required="true"/></dd>
<cfif subType.getType() neq "Custom">
<dt>Container</dt>
<dd><select name="container">
<option value="Default">Extended Attributes Tab</option>
<cfif subType.getTYpe() neq "Site">
<option value="Basic"<cfif extendSetBean.getContainer() eq "Basic"> selected</cfif>>Basic Tab</option></cfif>
<option value="Custom"<cfif extendSetBean.getContainer() eq "Custom"> selected</cfif>>Custom UI</option>
</select>
</dd>
<cfelse>
<input name="container" value="Custom" type="hidden"/>	
</cfif>
<cfif  not listFindNoCase("1,Site,Custom", subtype.getType()) and application.categoryManager.getCategoryCount(rc.siteID)>
<dt>Available Category Dependencies</dt>
<dd class="categoryAssignment"><cf_dsp_categories_nest siteID="#rc.siteID#" parentID="" nestLevel="0" extendSetBean="#extendSetBean#"></dd>
</cfif></dl>
<div class="clearfix" id="actionButtons">
<cfif not len(rc.extendSetID)>
	<input type="button" class="submit" onclick="submitForm(document.forms.form1,'add');" value="Add" />
	<input type=hidden name="extendSetID" value="#createuuid()#">
<cfelse>
	<input type="button" class="submit" onclick="submitForm(document.forms.form1,'delete','Delete Attribute Set?');" value="Delete" />
	<input type="button" class="submit" onclick="submitForm(document.forms.form1,'update');" value="Update" />
	<input type=hidden name="extendSetID" value="#extendSetBean.getExtendSetID()#">
</cfif>
</div>

<input type="hidden" name="action" value="">
<input name="muraAction" value="cExtend.updateSet" type="hidden">
<input name="siteID" value="#HTMLEditFormat(rc.siteid)#" type="hidden">
<input name="subTypeID" value="#subType.getSubTypeID()#" type="hidden">
</form>
</cfoutput>