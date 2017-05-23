// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "web/static/js/app.js".

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/my_app/endpoint.ex":
//import {Socket} from "deps/phoenix/web/static/js/phoenix"
import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

// When you connect, you'll often need to authenticate the client.
// For example, imagine you have an authentication plug, `MyAuth`,
// which authenticates the session and assigns a `:current_user`.
// If the current user exists you can assign the user's token in
// the connection for use in the layout.
//
// In your "web/router.ex":
//
//     pipeline :browser do
//       ...
//       plug MyAuth
//       plug :put_user_token
//     end
//
//     defp put_user_token(conn, _) do
//       if current_user = conn.assigns[:current_user] do
//         token = Phoenix.Token.sign(conn, "user socket", current_user.id)
//         assign(conn, :user_token, token)
//       else
//         conn
//       end
//     end
//
// Now you need to pass this token to JavaScript. You can do so
// inside a script tag in "web/templates/layout/app.html.eex":
//
//     <script>window.userToken = "<%= assigns[:user_token] %>";</script>
//
// You will need to verify the user token in the "connect/2" function
// in "web/channels/user_socket.ex":
//
//     def connect(%{"token" => token}, socket) do
//       # max_age: 1209600 is equivalent to two weeks in seconds
//       case Phoenix.Token.verify(socket, "user socket", token, max_age: 1209600) do
//         {:ok, user_id} ->
//           {:ok, assign(socket, :user, user_id)}
//         {:error, reason} ->
//           :error
//       end
//     end
//
// Finally, pass the token on connect as below. Or remove it
// from connect if you don't care about authentication.

socket.connect()


let channel_weathering = socket.channel("weathering:lobby", {})
let select_customer = $("#select_customer")
let select_project = $("#select_project")
let select_equipment = $("#select_equipment")
let register_wear = $("#register_wear")
let button_wear = $("#button_wear")
let modal_magnitudes = $("#modal_magnitudes")




console.log("Iniciando button_wear")
button_wear.click(() => {
  // let measurement_id = ""
  console.log("button_wear")
  alert("Click....")
  // channel_weathering.push('get_magnitudes', {measurement_id: measurement_id})
})

select_customer.change(() => {
    let customer_id = select_customer.find(":selected").val()
    // console.log("customer_id:" + customer_id)
    channel_weathering.push('get_projects', {customer_id: customer_id})
})

select_project.change(() => {
    let project_id = select_project.find(":selected").val()
    // console.log("project_id:" + project_id)
    channel_weathering.push('get_equipments', {project_id: project_id})
})

select_equipment.change(() => {
    let equipment_id = select_equipment.find(":selected").val()
    // console.log("equipment_id:" + equipment_id)
    channel_weathering.push('get_bucket', {equipment_id: equipment_id})
})

channel_weathering.on('populate_projects', payload => {
  select_project.empty()
  select_project.append(payload.html)
  select_project.material_select()
  // console.log(payload.html)
})

channel_weathering.on('populate_equipments', payload => {
  select_equipment.empty()
  select_equipment.append(payload.html)
  select_equipment.material_select()
  // console.log(payload.html)
})

channel_weathering.on('register_wear_parts_bucket', payload => {
  register_wear.empty()
  register_wear.append(payload.html)
  // $('.modal').modal()
  // console.log(payload.html)
})

channel_weathering.on('modal_magnitudes', payload => {
  modal_magnitudes.empty()
  modal_magnitudes.append(payload.html)
  // console.log(payload.html)
})

channel_weathering.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

export default socket
