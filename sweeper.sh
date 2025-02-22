#!/bin/bash
source monero-wallet-rpc.sh
validate_time() {
    local time="$1"
    if [[ "$time" =~ ^([01][0-9]|2[0-3]):([0-5][0-9])$ ]]; then
        return 0
    else
        return 1
    fi
}
read -r -p "Specify the wallet filename: " -i "my_monero_wallet" wallet
read -r -p "Specify the wallet password: " -i "test" password
while ! validate_time "$time"; do
    echo "Invalid time format. Please use HH:MM format and try again."
    read -r -p "Schedule at what hour you want to transact (HH:MM), MAKE SURE THOSE NUMBERS ARE TRULY RANDOM WITH A DICE: " -i "HH:MM" time
done
read -r -p "Specify the address where funds will be sent: " -i "888tNkZrPN6JsEgekjMnABU4TBzc2Dt29EPAvkRxbANsAnjyPbb3iQ1YBRk1UXcdRsiKc9dhwMVgN5S9cQUiyoogDavup3H" address
echo "open_wallet ${wallet} ${password}; sweep_all ${address}" | at ${time}
unset ${wallet}
unset ${password}
unset ${address}
unset ${time}
