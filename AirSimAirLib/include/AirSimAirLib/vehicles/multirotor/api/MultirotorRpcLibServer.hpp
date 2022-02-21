// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.

#ifndef air_MultirotorRpcLibServer_hpp
#define air_MultirotorRpcLibServer_hpp

#include "AirSimAirLib/common/Common.hpp"
#include <functional>
#include "AirSimAirLib/api/RpcLibServerBase.hpp"
#include "AirSimAirLib/vehicles/multirotor/api/MultirotorApiBase.hpp"

namespace msr
{
namespace airlib
{

    class MultirotorRpcLibServer : public RpcLibServerBase
    {
    public:
        MultirotorRpcLibServer(ApiProvider* api_provider, string server_address, uint16_t port = RpcLibPort);
        virtual ~MultirotorRpcLibServer();

    protected:
        virtual MultirotorApiBase* getVehicleApi(const std::string& vehicle_name) override
        {
            return static_cast<MultirotorApiBase*>(RpcLibServerBase::getVehicleApi(vehicle_name));
        }
    };
}
} //namespace
#endif
