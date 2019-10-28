type attendee is address;
type action is 
| Showed of attendee
| Booked of attendee

type attendee_list is set(attendee);

type event is record
  booked : attendee_list;
  showed : attendee_list;
end


function add_attendee_to_list(const attendee: attendee; const cur_attendee_list: attendee_list): attendee_list is
    block{
        const new_attendee_list : attendee_list = set_add(attendee, cur_attendee_list);
    } with new_attendee_list
  
function main(const parameter: action; const store: event) : (list(operation) * event) is
    block { 
        case parameter of 
        | Showed (attendee) -> store.showed := add_attendee_to_list(attendee, store.showed)
        | Booked (attendee) -> store.booked := add_attendee_to_list(attendee, store.booked)
    end } with ((nil:list(operation)), store)


