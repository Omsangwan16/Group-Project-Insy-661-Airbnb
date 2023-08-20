
#using streamlit to connect my database
#https://docs.streamlit.io/en/stable/tutorial/create_a_data_explorer_app.html

import streamlit as st
from helper import read_queries_from_file, get_queries

st.set_page_config(layout="wide")
st.title('Group 8 INSY 661 - Airbnb')

# Initialize connection.
conn = st.experimental_connection('mysql', type='sql')




queries, schema, user_interaction = st.tabs(["Queries", "Database Schema", "Interact With Database"])


with queries:
    st.subheader('Queries')
    # Perform query.
    
    query = read_queries_from_file("query.sql")
    
    query_codes = get_queries()

    num = 0
    for query_line in query:
        with st.expander(f"Query {num+1}: {query_line['title']}"):
                st.markdown("#### Business objective")
                st.write(query_line['business_objective'])
                st.write("\n #### Query") 
                st.code(query_codes[num], language="sql", line_numbers=True)
                st.write("#### Output")
                st.dataframe(conn.query(query_codes[num]), use_container_width=True, hide_index=True)
                num=num+1
with schema:
    st.subheader('Database Schema')
    st.image('schema.jpeg')

with user_interaction:
            query_code = st.text_input("Enter your query:")

            run_query = st.button("Run query", key="0")
            if run_query and query_code != "":
                with st.spinner("Running query..."):
                    st.dataframe(
                        conn.query(query_code),
                        use_container_width=True,
                        hide_index=True,
                    )
     

