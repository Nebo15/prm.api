defmodule PRM.Web.EmployeeView do
  @moduledoc false

  use PRM.Web, :view
  alias PRM.Web.EmployeeView

  def render("index.json", %{employees: employees}) do
    render_many(employees, EmployeeView, "employee.json")
  end

  def render("show.json", %{employee: employee}) do
    render_one(employee, EmployeeView, "employee.json")
  end

  def render("employee.json", %{employee: %{employee_type: "DOCTOR", doctor: doctor} = employee}) do
    employee
    |> render_employee()
    |> render_doctor(doctor)
  end

  def render("employee.json", %{employee: employee}) do
   render_employee(employee)
  end

  def render_employee(employee) do
   %{
      id: employee.id,
      position: employee.position,
      status: employee.status,
      employee_type: employee.employee_type,
      is_active: employee.is_active,
      inserted_by: employee.inserted_by,
      updated_by: employee.updated_by,
      start_date: employee.start_date,
      end_date: employee.end_date,
    }
    |> render_association(employee.party, :party, employee.party_id)
    |> render_association(employee.division, :division, employee.division_id)
    |> render_association(employee.legal_entity, :legal_entity, employee.legal_entity_id)
  end

  def render_association(map, %Ecto.Association.NotLoaded{}, key, default) do
    key =
      key
      |> Atom.to_string()
      |> Kernel.<>("_id")
      |> String.to_atom()

    Map.put(map, key, default)
  end

  def render_association(map, %PRM.Parties.Party{} = party, key, _default) do
    data = %{
      id: party.id,
      first_name: party.first_name,
      last_name: party.last_name,
      second_name: party.second_name,
    }
    Map.put(map, key, data)
  end

  def render_association(map, %PRM.Entities.Division{} = division, key, _default) do
    data = %{
      id: division.id,
      type: division.type,
      legal_entity_id: division.legal_entity_id,
      mountain_group: division.mountain_group,
    }
    Map.put(map, key, data)
  end

  def render_association(map, %PRM.Entities.LegalEntity{} = legal_entity, key, _default) do
    data = %{
      id: legal_entity.id,
      name: legal_entity.name,
      short_name: legal_entity.short_name,
      public_name: legal_entity.public_name,
      type: legal_entity.type,
      edrpou: legal_entity.edrpou,
      status: legal_entity.status,
      owner_property_type: legal_entity.owner_property_type,
      legal_form: legal_entity.legal_form,
    }
    Map.put(map, key, data)
  end

  def render_association(map, _assoc, key, default), do: Map.put(map, key, default)

  def render_doctor(map, %Ecto.Association.NotLoaded{}), do: Map.put(map, :doctor, nil)
  def render_doctor(map, doctor), do: Map.put(map, :doctor, doctor)
end
