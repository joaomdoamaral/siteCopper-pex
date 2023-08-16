<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.neomind.fusion.portal.PortalUtil"%>
<%@page import="com.neomind.fusion.i18n.I18nUtils"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="<%=PortalUtil.getBaseURL()%>cingo/utils/css/dataTables.bootstrap.css">
<script type="text/javascript" language="javascript" src="<%=PortalUtil.getBaseURL() %>cingo/utils/js/datatables/jquery.dataTables.min.js"></script>
<script type="text/javascript" language="javascript" src="<%=PortalUtil.getBaseURL() %>cingo/utils/js/datatables/jquery.dataTables.js"></script>
<script type="text/javascript" language="javascript" src="<%=PortalUtil.getBaseURL() %>cingo/utils/js/datatables/bootstrap.dataTables.js"></script>
<link href="<%=PortalUtil.getBaseURL()%>cingo/utils/css/datepicker.css" rel="stylesheet">
<script src="<%=PortalUtil.getBaseURL()%>cingo/utils/js/lib/bootstrap-datepicker.js"></script>
<title>Painel de Assessment DHO</title>
</head>

<style>
</style>

<body>
<div class="panel panel-default" style="margin: 5px; overflow:auto;" >
	<div class="panel-heading">Painel de Assessment DHO</div>
	<form id="mainForm" role="form">
		<div class="panel-body" style="top: 80px;">
			<div class="row">
				<div class="col-md-2 col-lg-2" id="divEmpresa">
					<div class="form-group">
						<label for="tema">Empresa</label> 
						<select class="form-control" id="empresa" name="empresa">
						</select>
					</div>
				</div>
				<div class="col-md-2 col-lg-2" id="divPessoaFisica">
					<div class="form-group">
						<label for="tema">Pessoa Física</label> 
						<input type="number"  class="form-control" id="pessoaFisica" name="pessoaFisica">
					</div>
				</div>
				<div class="col-md-2 col-lg-2" id="divEstabelecimento">
					<div class="form-group">
						<label for="tema">Estabelecimento</label> 
						<select class="form-control"  id="estabelecimento" name="estabelecimento">
						</select>
					</div>
				</div>
				<div class="col-md-2 col-lg-2" id="divMatricula">
					<div class="form-group">
						<label for="tema">Matrícula</label> 
						<input type="number" class="form-control"  id="matricula" name="matricula">
					</div>
				</div>
				<div class="col-md-2 col-lg-2" id="divCentroCustos">
					<div class="form-group">
						<label >Centro de Custos</label> 
						<select class="form-control"  id="centroCustos" name="centroCustos">
						</select>
					</div>
				</div>
				<div class="col-md-2 col-lg-2" id="divCargo">
					<div class="form-group">
						<label >Cargo</label> 
						<select class="form-control"  id="cargo" name="cargo">
						</select>
					</div>
				</div>
				<div class="col-md-2 col-lg-2" id="divUnidadeNegocio">
					<div class="form-group">
						<label for="tema">Unidade de Negócio</label> 
						<select class="form-control"  id="unidadeNegocio" name="unidadeNegocio">
						</select>
					</div>
				</div>
				<div class="col-md-2 col-lg-2" id="divBase">
					<div class="form-group">
						<label >Base</label> 
						<select class="form-control"  id="base" name="base">
						</select>
					</div>
				</div>
				<div class="col-md-2 col-lg-2" id="divRegional">
					<div class="form-group">
						<label >Regional</label> 
						<select class="form-control"  id="regional" name="regional">
						</select>
					</div>
				</div>
				<div class="col-md-2 col-lg-2" id="divGestorAtual">
					<div class="form-group">
						<label >Gestor Atual</label> 
						<select class="form-control"  id="gestorAtual" name="gestorAtual">
						</select>
					</div>
				</div>
				<div class="col-md-2 col-lg-2" id="divSituacao">
					<div class="form-group">
						<label >Situação</label> 
						<select class="form-control"  id="situacao" name="situacao">
						</select>
					</div>
				</div>
			</div>
			<div class="modal-footer" style="margin-top: 20px">
				<p align="right">
					<button type="button" class="btn btn-secondary btn-md" id="limparCampos">Limpar Campos </button>
					<button type="submit" class="btn btn-primary btn-md" id="btnBuscar">Buscar </button>
				</p>
			</div>
		</div>
	</form>
</div>
</body>
</html>

<script>

$("#empresa").select2({
	ajax: {
		url: '<%=PortalUtil.getBaseURL()%>sistemas/zoomloader?type=Empresa&serverside=true&filterSubFields=false',
		dataType: 'json',
	    data: function (params) {
	    	return {
		    		sSearch: params.term, // search term
		    		page: params.page
		      	};
		    },
		    processResults: function (data, page) {
		    	var selectdata = [];
		    	for (r=0;r<data.aaData.length;r++){
					selectdata.push({id:data.aaData[r].neoId, text:data.aaData[r].codigo + ' - ' + data.aaData[r].descricao});
				}
				
		      	return {
		        	results: selectdata
		      	};
		    },
	    	cache: true
	},
	escapeMarkup: function (markup) { return markup; },
  	allowClear: true,
  	placeholder : 'Selecione a Empresa'
});

$("#estabelecimento").select2({
	ajax: {
		url: function(){
			var empresa = $('#empresa').val();
			if(empresa == null){
				return '<%=PortalUtil.getBaseURL()%>sistemas/zoomloader?type=Estabelecimento&serverside=true&filterSubFields=false'; 
			}
			else
			{
				return '<%=PortalUtil.getBaseURL()%>sistemas/zoomloader?type=Estabelecimento&serverside=true&filterSubFields=false&fieldFilter1=empresa.neoId&valueFilter1=' + empresa;
			}
		},
		dataType: 'json',
	    data: function (params) {
	    	return {
		    		sSearch: params.term, // search term
		    		page: params.page
		      	};
		    },
		    processResults: function (data, page) {
		    	var selectdata = [];
		    	for (r=0;r<data.aaData.length;r++){
					selectdata.push({id:data.aaData[r].neoId, text:data.aaData[r].codigo + ' - ' + data.aaData[r].descricao});
				}
				
		      	return {
		        	results: selectdata
		      	};
		    },
	    	cache: true
	},
	escapeMarkup: function (markup) { return markup; },
  	allowClear: true,
  	placeholder : 'Selecione o Estabelecimento'
});

$("#unidadeNegocio").select2({
	ajax: {
		url: '<%=PortalUtil.getBaseURL()%>sistemas/zoomloader?type=UnidadeNegocio&serverside=true&filterSubFields=false',
		dataType: 'json',
	    data: function (params) {
	    	return {
		    		sSearch: params.term, // search term
		    		page: params.page
		      	};
		    },
		    processResults: function (data, page) {
		    	var selectdata = [];
		    	for (r=0;r<data.aaData.length;r++){
					selectdata.push({id:data.aaData[r].neoId, text:data.aaData[r].sigla + ' - ' + data.aaData[r].descricao});
				}
				
		      	return {
		        	results: selectdata
		      	};
		    },
	    	cache: true
	},
  	escapeMarkup: function (markup) { return markup; },
  	allowClear: true,
  	placeholder : 'Selecione a Unidade de Negócio'
});

$("#centroCustos").select2({
	ajax: {
		url: function(){
			var empresa = $('#empresa').val();
			if (empresa != null && empresa > 0){
				return '<%=PortalUtil.getBaseURL()%>sistemas/zoomloader?type=CentroCustos&serverside=true&filterSubFields=false&fieldFilter1=empresa.neoId&valueFilter1=' + empresa; 
			}
			else{
				return '<%=PortalUtil.getBaseURL()%>sistemas/zoomloader?type=CentroCustos&serverside=true&filterSubFields=false';
			}
		},
		dataType: 'json',
	    data: function (params) {
	    	return {
		    		sSearch: params.term, // search term
		    		page: params.page
		      	};
		    },
		    processResults: function (data, page) {
		    	var selectdata = [];
		    	for (r=0;r<data.aaData.length;r++){
					selectdata.push({id:data.aaData[r].neoId, text:data.aaData[r].sigla + ' - ' + data.aaData[r].descricao});
				}
				
		      	return {
		        	results: selectdata
		      	};
		    },
	    	cache: true
	},
  	escapeMarkup: function (markup) { return markup; },
  	placeholder: 'Centro de Custos',
    allowClear: true
});

$("#base").select2({
	ajax: {
		url: function(){
			var empresa = $('#empresa').val();
			if(empresa != null && empresa > 0){
				return '<%=PortalUtil.getBaseURL()%>sistemas/zoomloader?type=BaseRegional&serverside=true&filterSubFields=false&fieldFilter1=empresa.neoId&valueFilter1=' + empresa;
			}
			else
			{
				return '<%=PortalUtil.getBaseURL()%>sistemas/zoomloader?type=BaseRegional&serverside=true&filterSubFields=false';
			}
		},
		dataType: 'json',
	    data: function (params) {
	    	return {
		    		sSearch: params.term, // search term
		    		page: params.page
		      	};
		    },
		    processResults: function (data, page) {
		    	var selectdata = [];
		    	for (r=0;r<data.aaData.length;r++){
					selectdata.push({id:data.aaData[r].neoId, text:data.aaData[r].base + ' - ' + data.aaData[r].descBase});
				}
				
		      	return {
		        	results: selectdata
		      	};
		    },
	    	cache: true
	},
	escapeMarkup: function (markup) { return markup; },
  	allowClear: true,
  	placeholder : 'Selecione a Base'
});

$("#regional").select2({
	debugger;
	ajax: {
		url: function(){
			var empresa = $('#empresa').val();
			var codigoEmpresa = getCodigoEmpresa(empresa);
			if(empresa != null && empresa > 0){
				return '<%=PortalUtil.getBaseURL()%>sistemas/zoomloader?type=BaseRegional&serverside=true&filterSubFields=false&fieldFilter1=empresa&valueFilter1=' + empresa;
			}
			else
			{
				return '<%=PortalUtil.getBaseURL()%>sistemas/zoomloader?type=BaseRegional&serverside=true&filterSubFields=false';
			}
		},
		dataType: 'json',
	    data: function (params) {
	    	return {
		    		sSearch: params.term, // search term
		    		page: params.page
		      	};
		    },
		    processResults: function (data, page) {
		    	var selectdata = [];
		    	for (r=0;r<data.aaData.length;r++){
					selectdata.push({id:data.aaData[r].neoId, text:data.aaData[r].regional + ' - ' + data.aaData[r].descRegional});
				}
				
		      	return {
		        	results: selectdata
		      	};
		    },
	    	cache: true
	},
	escapeMarkup: function (markup) { return markup; },
  	allowClear: true,
  	placeholder : 'Selecione a Regional'
});

function getCodigoEmpresa(empresaId)
{
	debugger;
	ajax: {
		url: '<%=PortalUtil.getBaseURL()%>sistemas/zoomloader?type=Empresa&serverside=true&filterSubFields=false&fieldFilter1=empresa.neoId&valueFilter1=' + empresaId;',
		dataType: 'json',
	    data: function (params) {
	    	return {
		    		sSearch: params.term, // search term
		    		page: params.page
		      	};
		    },
		    processResults: function (data, page) {
		   		var codigoEmpresa = data.aaData[r].codigo;
		      	return codigoEmpresa;
		    }
	}
}

function getCodigoEstabelecimento(estabelecimentoId)
{
	
}

function getCodigoCentroCustos(centroCustosId)
{
	
}


</script>