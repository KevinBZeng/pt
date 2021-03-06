<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%	
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String roleId = request.getParameter("roleId");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">    
    <title>marketDealFdev</title>
   	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="<%=path %>/css/common.css" />
	<link rel="stylesheet" type="text/css" href="<%=path %>/css/main.css"/>
	<link rel="stylesheet" type="text/css" href="<%=path %>/css/dev.css" />
	<script type="text/javascript" src="<%=path %>/js/jquery-easyui-1.3.1/jquery-1.8.0.min.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=path %>/js/jquery-easyui-1.3.1/themes/default/easyui.css" />
	<link rel="stylesheet" type="text/css" href="<%=path %>/js/jquery-easyui-1.3.1/themes/icon.css" />
	<script type="text/javascript" src="<%=path %>/js/jquery-easyui-1.3.1/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=path %>/js/jquery-easyui-1.3.1/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="<%=path %>/js/commons.js"></script>
	<script type="text/javascript" src="<%=path %>/js/vobCombox.js"></script>
	<script type="text/javascript" src="<%=path %>/js/LG.js"></script>
 </head>
 
 <body style="overflow:hidden">
 	<script type="text/javascript">
 		$(function(){
 			 /**
	    	 *罗列签约机构
	    	 **/
	    	$('#selectedSignDepartment').html("");			//清空已选项
	    	var str = "";
	    	var type = "0";
	    	var signDepartment = $('#signDepartment').attr('value');
	    	var signDepartmentId = $('#signDepartmentId').attr('value');
			if(signDepartment!=''){					//归属机构内部有值，点击选择进行选择时需要显示,所以有if{}内部的代码
				str += "<tr><td><input type='checkbox' checked='checked'/>"+signDepartment+"</td>";
				str += "<td style='display:none'>"+signDepartmentId+"</td></tr>";
				$('#selectedSignDepartment').append(str);
			}
	    	$('#signDepartList').datagrid({
	    		 fit:true ,
				 height:450 ,
	            url: 'queryDepartmentList!queryDepartmentList.action',
	             method: 'post',
	             loadMsg: '数据正在加载,请耐心的等待...' ,
	             fitColumns:true ,  
				 striped: true ,					//隔行变色特性
	             rownumbers:true ,					//显示行号
	             pagination: true , 				//显示分页
	             onLoadSuccess: function (data){					
					LG.showMsg("查询结果提示",data.retCode,data.message,false);
				 },
				 onLoadError: function (xhr,data){
					showErrorMessage(xhr);
				 },
	             frozenColumns:[[				//冻结列特性 ,不要与fitColumns 特性一起使用 
					{
						field:'ck' ,
						width:50 ,
						checkbox: true
					}
				 ]],
				 pageSize: 10 ,
				 pageList:[10,20,50],
				 toolbar:[
					 {
						 text:'选择',
						 iconCls:'icon-add',
						 handler:function(){
						 	var trNum = $('#selectedSignDepartment tr').size();	//判断已经选择了几个选项,selectedSignDepartment关联的table下面有多少个tr
						 	if(trNum===1){
						 		LG.showWarn("提示消息","已存在一个选项!");
						 	}else if(trNum===0){									//如果没有选项，则可选择一个
						 		var str= "";
							 	var arr = $('#signDepartList').datagrid('getSelections');
							 	var signDepartment = "";
							 	var signDepartmentId = "";
							 	if(arr.length <=0){
							 		LG.showWarn("提示消息","请至少选择一项!");
							 	}else if(arr.length != 1){
							 		LG.showWarn("提示消息","只能选择一项!");
							 	}else{
							 		signDepartment = arr[0].departmentName;
							 		signDepartmentId = arr[0].departmentId;
							 		str += "<tr><td><input type='checkbox' checked='checked'/>"+signDepartment+"</td>";
							 		str += "<td style='display:none'>"+signDepartmentId+"</td></tr>";
							 		$('#selectedSignDepartment').append(str);
							 	}
						 	}
						 }
					 }
				 ],
				 columns:[[
					 {
						 field:'departmentId',title:'机构编号',width:100,align:'center'
					 },{
						 field:'departmentName',title:'机构名称',width:100,align:'center'
					 },{
						 field:'departmentType' ,
						 title:'业务' ,
						 width:100,
						 sortable : true,
						 align:'center' ,
						 formatter:function(value , record , index){
							 if(value == 0){
							 	return '<span style=color:black; >超级管理员</span>' ;
							 }else if(value == 1){
							 	return '<span style=color:green; >深度开发</span>' ;
							 }else if(value == 2){
							 	return '<span style=color:blue; >私银销售</span>' ;
							 }
						 }
					 },{
						 field:'type' ,
						 title:'机构类型' ,
						 width:100 ,
						 align:'center' ,
						 formatter:function(value , record , index){
							 if(value == 0){
						 		return '<span style=color:blue; >一级分行</span>';
						 	 } else if( value == 1){
								return '<span style=color:blue;>同城支行</span>'; 
							 } else if( value == 2){
								return '<span style=color:blue;>部门</span>'; 
							 } else if( value == 3){
								return '<span style=color:green;>异地分行</span>'; 
							 } else if( value == 4){
								return '<span style=color:green;>异地支行</span>'; 
							 } else if( value == 5){
								return '<span style=color:green;>异地部门</span>'; 
							 }	
						}
					}
				 ]]
			});
	    	 /**
	    	 * 将选择机构选中的保存或清除
	    	 */
	     	/**
	     	 * 下面是保存按钮
	     	 * @memberOf {TypeName} 
	     	 */
		    $("#saveSignDep").click(function(){
		    	var arrSignDepart = [];
		    	var arrSignDepartId = [];
		    	if($('#selectedSignDepartment tr').size()===0){			//判断table里面是否包含tr
		    		LG.showWarn("提示消息","已选项为空，请添加选项!");
		    	}else{
		    		$('#selectedSignDepartment tr').each(function(){	//如果包含tr,开始遍历每个tr内部每个td的内容
		    			if($(this).children("td").eq(0).find("input:checkbox").prop("checked")){
		    				 arrSignDepart[arrSignDepart.length] = $(this).children("td").eq(0).text();
		    				 arrSignDepartId[arrSignDepartId.length] = $(this).children("td").eq(1).text();
		    			}
		    		});
		    		var arrSignDepartNum = arrSignDepart.length;
		    		var signDepart = "";
		    		var signDepartId = "";
		    		if(arrSignDepartNum>0){
		    			for(var i=0;i<arrSignDepartNum;i++){
		    				signDepart += arrSignDepart[i]+',';
		    				signDepartId += arrSignDepartId[i]+',';
		    			}
		    			signDepart = signDepart.substring(0,signDepart.length-1);
		    			signDepartId = signDepartId.substring(0,signDepartId.length-1);
		    			$('#signDepartment').val(signDepart);
		    			$('#signDepartmentId').val(signDepartId);
		    			$('#signDepartmentDialog').dialog('close');		//关闭选择窗口
		    		}else{
		    			LG.showWarn("提示消息","未勾选需保存的选项!");
		    		}
		    	}
		    });
		      /**
		       * 移除已选项中选中的项
		       * @memberOf {TypeName} 
		       */
		    $("#removeSignDep").click(function(){
		    	var i = 0;
			    if($('#selectedSignDepartment tr').size()===0){			//判断table里面是否包含tr
			    	LG.showWarn("提示消息","已选项为空!");
			    }else{
			    	$('#selectedSignDepartment tr').each(function(){	//如果包含tr,开始遍历每个tr内部每个td的内容
			    		if($(this).children("td").eq(0).find("input:checkbox").prop("checked")){
			    			$(this).remove();
			    			i++;
			    		}
			    	});
			    	if(i===0){
			    		LG.showWarn("提示消息","未勾选需移除的选项!");
			    	}
				}
		    });
		    $('#searchSignDepbtn').click(function(){
				$('#signDepartList').datagrid('load' ,serializeForm($('#mysearchSignDep')));
			});
			
			$('#clearSignDepbtn').click(function(){
				$('#mysearchSignDep').form('clear');
				$('#signDepartList').datagrid('load' ,{});
			});
		});
 	</script>
 	<div id="lay" class="easyui-layout" style="width:100%;height:100%" >
		<div region="north" align="center" style="background-color:#E4F5EF;width:100%;height:35%;overflow:hidden">
			<form id="mysearchSignDep" method="post">
				<table width="100%">
					<tr>
						<td width="15%">&nbsp;机构编码:&nbsp;<input name="departmentId" value="" style="width:60%;height:22px;border:1px solid #A4BED4;"/></td>
						<td width="20%">&nbsp;机构名称:&nbsp;<input name="departmentName" value="" style="width:60%;height:22px;border:1px solid #A4BED4;"/></td>
						<td width="15%" align="left"><a id="searchSignDepbtn" href="javascript:void(0)" class="easyui-linkbutton">查询</a> <a id="clearSignDepbtn" href="javascript:void(0)" class="easyui-linkbutton">重置</a></td>
					</tr>						
				</table>
			</form>
		</div>
		<div region="east" title="已选项" split="true" style="background-color:#E4F5EF;width:160px;height:35%">
			<div style="height:70%">
				<table id="selectedSignDepartment">
				</table>
			</div>
			<hr>
			<div>
				<table>
					<tr>
						<td colspan="2">
							<a href="javascript:void(0)" id="saveSignDep" class="easyui-linkbutton">保存</a>
							<a href="javascript:void(0)" id="removeSignDep" class="easyui-linkbutton">移除</a>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div region="center" style="overflow:auto;background-color:#E4F5EF;width:100%;height:100%">
			<table id="signDepartList" title="机构信息列表" class="easyui-datagrid" align="center" border="1" style="height:auto;background-color:#E4F5EF">
			</table>
		</div>
	</div>
 </body>
 </html>