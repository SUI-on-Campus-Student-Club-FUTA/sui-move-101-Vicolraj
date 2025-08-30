#[test_only]
module workshop_project::todo_list_test {
    use std::string;
    use sui::tx_context;
    use workshop_project::todo_list;
    use workshop_project::todo_list::TodoList;

    const ENotFound: u64 = 1000;

    #[test_only]
    fun test_create_list(): TodoList {
        let ctx = &mut tx_context::dummy();
        todo_list::new(ctx)
    }

    #[test]
    fun test_todo_list() {
        let mut list = test_create_list();

        todo_list::add(&mut list, string::utf8(b"wash my clothes!"));
        assert!(todo_list::get_item(&list, 0) == string::utf8(b"wash my clothes!"), ENotFound);

        todo_list::add(&mut list, string::utf8(b"Buy garri!"));
        todo_list::add(&mut list, string::utf8(b"Stream online"));

        assert!(todo_list::length(&list) == 3, ENotFound);

        todo_list::delete(list);
    }
}
