/** Data Layer for Checkout page */
var logState = {
    {% if shop.customer_accounts_enabled %}
    {% if customer %}
    'userId'        : {{ customer.id | json }},
    'customerEmail' : {{ customer.email | json }},
    'logState'      : "Logged In",
    'customerInfo'  : {
        'firstName'   : {{ customer_address.first_name | json }},
        'lastName'    : {{ customer_address.last_name | json }},
        'address1'    : {{ customer_address.address1 | json }},
        'address2'    : {{ customer_address.address2 | json }},
        'street'      : {{ customer_address.street | json }},
        'city'        : {{ customer_address.city | json }},
        'province'    : {{ customer_address.province | json }},
        'zip'         : {{ customer_address.zip | json }},
        'country'     : {{ customer_address.country | json }},
        'phone'       : {{ customer_address.phone | json }},
        'lastOrder'   : "{{ customer.orders.first.created_at | date: '%B %d, %Y %I:%M%p' }}",
        'totalOrders' : {{ customer.orders_count | json }},
        'totalSpent'  : {{ customer.total_spent | money_without_currency | remove: "," | json }},
        'totalSpents' : {{ checkout.customer.total_spent | money_without_currency | remove: "," | times: 0.01 | json }},
        'tags'        : {{ customer.tags | json }}
    },
    {% else %}
    'logState' : "Logged Out",
    {% endif %}
    {% endif %}
    'firstLog'      : firstLog,
    'timestamp'     : Date().replace(/\(.*?\)/g,''),

    {% if customer.orders_count > 2 %}
    'customerType'       : 'member',
    'customerTypeNumber' : '0',
    'lastOrder'          : "{{ customer.orders.first.created_at | date: '%B %d, %Y %I:%M%p' }}",
    'totalOrders'        : {{ customer.orders_count | json }},
    'totalSpent'         : {{ customer.total_spent | money_without_currency | remove: "," | json }},
    'totalSpents'        : {{ checkout.customer.total_spent | money_without_currency | remove: "," | times: 0.01 | json }},
    'tags'               : {{ customer.tags | json }},
    {% else %}
    'customerType'       : 'guest',
    'customerTypeNumber' : '1',
    {% endif %}

    'shippingInfo' : {
        'fullName'  : {{ checkout.shipping_address.name | json }},
        'firstName' : {{ checkout.shipping_address.first_name | json }},
        'lastName'  : {{ checkout.shipping_address.last_name | json }},
        'address1'  : {{ checkout.shipping_address.address1 | json }},
        'address2'  : {{ checkout.shipping_address.address2 | json }},
        'street'    : {{ checkout.shipping_address.street | json }},
        'city'      : {{ checkout.shipping_address.city | json }},
        'province'  : {{ checkout.shipping_address.province | json }},
        'zip'       : {{ checkout.shipping_address.zip | json }},
        'country'   : {{ checkout.shipping_address.country | json }},
        'phone'     : {{ checkout.shipping_address.phone | json }}
    },

    'billingInfo' : {
        'fullName'  : {{ checkout.billing_address.name | json }},
        'firstName' : {{ checkout.billing_address.first_name | json }},
        'lastName'  : {{ checkout.billing_address.last_name | json }},
        'address1'  : {{ checkout.billing_address.address1 | json }},
        'address2'  : {{ checkout.billing_address.address2 | json }},
        'street'    : {{ checkout.billing_address.street | json }},
        'city'      : {{ checkout.billing_address.city | json }},
        'province'  : {{ checkout.billing_address.province | json }},
        'zip'       : {{ checkout.billing_address.zip | json }},
        'country'   : {{ checkout.billing_address.country | json }},
        'phone'     : {{ checkout.billing_address.phone | json }}
    },

    'checkoutEmail' : {{ checkout.email | json }},
    'currency'      : {{ shop.currency | json }},
    'pageType'      : 'Log State',
    'event'         : 'logState',

    // New parameter to check if the customer is a new or returning customer
    'new_customer': {{ customer.orders_count | default: 0 }} === 0 ? true : false,

    // Customer lifetime value (only reported if new_customer is true)
    'customer_lifetime_value': {{ customer.total_spent | money_without_currency | remove: "," | times: 0.01 | json }}
};

dataLayer.push(logState);

if (__DL__.debug) {
    console.log("Log State" + " :" + JSON.stringify(logState, null, " "));
}
