<% if namespaced? -%>
require_dependency "<%= namespaced_file_path %>/application_controller"

<% end -%>
<% module_namespacing do -%>
class <%= controller_class_name %>Controller < ApplicationController
  include MyUtility
  before_action :set_<%= singular_table_name %>, only: [:show, :edit, :update, :destroy]

  # GET <%= route_url %>
  def index
    param_set
    @count	= <%= class_name %>.includes([:p_name]).search(params[:q]).result.count()
    @search	= <%= class_name %>.includes([:p_name]).page(params[:page]).search(params[:q])
    @search.sorts = 'id asc' if @search.sorts.empty?
    @<%= plural_table_name %>	= @search.result.per(50)
  end

  def param_set
    @last_result = Name.maximum('result_no')
    params["result_no_form"] = params["result_no_form"] ? params["result_no_form"] : sprintf('%d',@last_result)
    params[:q]  = params[:q] ? params[:q] : {}
    
    reference_text_assign(params, "p_name_name", "p_name_form")
    <% attributes.reject(&:password_digest?).each do |attribute| -%>
    reference_number_assign(params, "<%= attribute.name %>", "<%= attribute.name %>_form")
    <% end -%>
    
    @p_name_form = params["p_name_form"]
    <% attributes.reject(&:password_digest?).each do |attribute| -%>
    @<%= attribute.name %>_form = params["<%= attribute.name %>_form"]
    <% end -%>
  end
  # GET <%= route_url %>/1
  #def show
  #end

  # GET <%= route_url %>/new
  #def new
  #  @<%= singular_table_name %> = <%= orm_class.build(class_name) %>
  #end

  # GET <%= route_url %>/1/edit
  #def edit
  #end

  # POST <%= route_url %>
  #def create
  #  @<%= singular_table_name %> = <%= orm_class.build(class_name, "#{singular_table_name}_params") %>

  #  if @<%= orm_instance.save %>
  #    redirect_to @<%= singular_table_name %>, notice: <%= "'#{human_name} was successfully created.'" %>
  #  else
  #    render action: 'new'
  #  end
  #end

  # PATCH/PUT <%= route_url %>/1
  #def update
  #  if @<%= orm_instance.update("#{singular_table_name}_params") %>
  #    redirect_to @<%= singular_table_name %>, notice: <%= "'#{human_name} was successfully updated.'" %>
  #  else
  #    render action: 'edit'
  #  end
  #end

  # DELETE <%= route_url %>/1
  #def destroy
  #  @<%= orm_instance.destroy %>
  #  redirect_to <%= index_helper %>_url, notice: <%= "'#{human_name} was successfully destroyed.'" %>
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_<%= singular_table_name %>
      @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    end

    # Only allow a trusted parameter "white list" through.
    def <%= "#{singular_table_name}_params" %>
      <%- if attributes_names.empty? -%>
      params[<%= ":#{singular_table_name}" %>]
      <%- else -%>
      params.require(<%= ":#{singular_table_name}" %>).permit(<%= attributes_names.map { |name| ":#{name}" }.join(', ') %>)
      <%- end -%>
    end
end
<% end -%>
