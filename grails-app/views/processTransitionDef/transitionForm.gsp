<!--
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
-->

<html>
    <head>
         <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
         <meta name="layout" content="grailsflow" />
         <g:render plugin="grailsflow" template="/commons/global"/>
         <title><g:message code="plugin.grailsflow.title.processTransitions"/></title>
    </head>
    <body>
      <h1><g:message code="plugin.grailsflow.label.processTransitions"/></h1>

      <g:render plugin="grailsflow" template="/commons/messageInfo"/>

      <g:form controller="${params['controller']}" method="POST">
        <input type="hidden" name="id" value="${transition?.id?.encodeAsHTML()}"/>
        <input type="hidden" name="fromNode" value="${transition?.fromNode?.id?.encodeAsHTML()}"/>

        <g:if test="${transition?.id}">
          <div class="row">
            <div class="col-md-8">
              <table>
                <tr>
                  <td>
                    <div style="border: #C0C0C0 1px solid; background-color: rgb(235,238,247); padding: 5px;">${transition?.fromNode?.nodeID?.encodeAsHTML()}</div>
                  </td>
                  <td>
                    <img src="${g.resource(plugin: 'grailsflow', dir:'images/grailsflow/general',file:'arrow_right_blue.gif')}"/>
                  </td>
                  <td>
                    <div style="border: #C0C0C0 1px solid; background-color: rgb(255,230,242); padding: 7px;">${transition?.event}</div>
                  </td>
                  <td>
                    <table>
                      <g:each in="${transition.toNodes}">
                        <tr>
                          <td>
                            <img src="${g.resource(plugin: 'grailsflow', dir:'images/grailsflow/general',file:'arrow_right_blue.gif')}"/>
                          </td>
                          <td>
                            <div style="border: #C0C0C0 1px solid; background-color: rgb(235,238,247); padding: 5px;">${it.nodeID}</div>
                          </td>
                        </tr>
                      </g:each>
                    </table>
                  </td>
                <tr>
              </table>
              <br/>
            </div>
          </div>

        </g:if>

        <div class="row">
          <div class="col-md-8">
            <div class="form-horizontal">
              <div class="form-group">
                <label class="col-md-2 control-label" for="fromNode">
                  <g:message code="plugin.grailsflow.label.fromNode"/>
                </label>
                <div class="col-md-10">
                  <input id="fromNode" class="form-control" readOnly="true" class="readonly" value="${transition?.fromNode?.nodeID?.encodeAsHTML()}" size="30"/>
                </div>
              </div>

              <div class="form-group">
                <label class="col-md-2 control-label" for="eventID">
                  <g:message code="plugin.grailsflow.label.event"/>
                </label>
                <div class="col-md-10">
                  <input name="eventID" id="eventID"  value="${transition?.event?.encodeAsHTML()}" class="form-control"/>
                  <g:if test="${transition?.id != null}">
                    &nbsp;&nbsp;&nbsp;
                    <g:link controller="${params['controller']}" action="editTranslations" id="${transition?.id}">
                      <g:message code="plugin.grailsflow.command.manageTranslations"/>
                    </g:link>
                  </g:if>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="row">
          <div class="col-md-6">
            <table class="table">
              <thead>
                <tr>
                  <th width="10%"><g:message code="plugin.grailsflow.label.toNodes"/></th>
                  <th><g:message code="plugin.grailsflow.label.nodeID"/></th>
                  <th><g:message code="plugin.grailsflow.label.type"/></th>
                </tr>
              </thead>
              <tbody>
                <g:each in="${transition?.fromNode?.processDef?.nodes}">
                  <tr>
                    <td>
                      <g:if test="${transition?.fromNode?.type == com.jcatalog.grailsflow.utils.ConstantUtils.NODE_TYPE_FORK}">
                        <g:checkBox name="toNode_${it.id}" value="${it?.incomingTransitions?.contains(transition)}" />
                      </g:if>
                      <g:else>
                        <g:radio name="toNode" value="${it.id}" checked = "${it?.incomingTransitions?.contains(transition)}" />
                      </g:else>
                    </td>
                    <td>${it.nodeID?.encodeAsHTML()}</td>
                    <td>${it.type?.encodeAsHTML()}</td>
                  </tr>
                </g:each>
              </tbody>
            </table>

            <div class="form-submit text-right">
              <g:actionSubmit action="toProcessEditor" id="${transition?.fromNode?.processDef?.id}" value="${g.message(code: 'plugin.grailsflow.command.back')}" class="btn btn-link"/>
              <g:if test="${transition?.id != null}">
                <g:actionSubmit onclick="return askConfirmation('${g.message(code: 'plugin.grailsflow.question.confirm')}');" action="deleteTransitonDef" value="${g.message(code: 'plugin.grailsflow.command.delete')}" class="btn btn-default"/>
              </g:if>
              <g:actionSubmit action="saveTransitionDef" value="${g.message(code: 'plugin.grailsflow.command.apply')}" class="btn btn-primary"/>
            </div>
          </div>
        </div>
      </g:form>

    </body>
</html>
